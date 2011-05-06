#import "EmoDatabase.h"
#import "Constants.h"
#import "EmoEngine.h"

static int database_preference_callback(void *arg, int argc, char **argv, char **column)  {
    NSString* value = (NSString*)arg;
    if (argc > 0) value = char2ns(argv[0]);
    return SQLITE_OK;
}

static int database_count_callback(void *arg, int argc, char **argv, char **column)  {
    int* count = (int*)arg;
    if (argc > 0) *count = atoi(argv[0]);
    return SQLITE_OK;
}

static int database_query_vector_callback(void *arg, int argc, char **argv, char **column)  {
    NSMutableArray* values = (NSMutableArray*)arg;
	
    for (int i = 0; i < argc; i++) {
        [values addObject:char2ns(argv[i])];
    }
	
    return SQLITE_OK;
}

@interface EmoDatabase (PrivateMethods)
-(NSInteger)exec:(const char*) sql;
-(NSInteger)exec_count:(const char*)sql count:(NSInteger*)count;
-(NSInteger)query_vector:(const char*) sql values:(NSMutableArray*)values;
@end

@implementation EmoDatabase
@synthesize lastError;
@synthesize lastErrorMessage;

- (id)init {
    self = [super init];
    if (self != nil) {
		isOpen = FALSE;
		lastError = SQLITE_OK;
		lastErrorMessage = nil;
    }
    return self;
}

-(NSInteger)exec:(const char*) sql {
	char* error;
	int rcode = sqlite3_exec(db, sql, NULL, 0, &error);
	if (rcode != SQLITE_OK) {
		self.lastError = rcode;
		self.lastErrorMessage = char2ns(error);
		sqlite3_free(error);
	}
	return rcode;
}

-(NSInteger)exec_count:(const char*)sql count:(NSInteger*)count {
	char* error;
	int rcode = sqlite3_exec(db, sql, database_count_callback, count, &error);
	if (rcode != SQLITE_OK) {
		self.lastError = rcode;
		self.lastErrorMessage = char2ns(error);
		sqlite3_free(error);
	}
	return rcode;
}

-(NSInteger)query_vector:(const char*) sql values:(NSMutableArray*)values {
	char* error;
	int rcode = sqlite3_exec(db, sql, database_query_vector_callback, values, &error);
	if (rcode != SQLITE_OK) {
		self.lastError = rcode;
		self.lastErrorMessage = char2ns(error);
		sqlite3_free(error);
	}
	return rcode;
}

-(BOOL)open:(NSString*) name {
	if (isOpen) return FALSE;
	
	NSString* path = [self getPath:name];
	
	int rcode = sqlite3_open([path UTF8String], &db);
	
	if (rcode != SQLITE_OK) {
		self.lastError = rcode;
		self.lastErrorMessage =  char2ns(sqlite3_errmsg(db));
	}
	
	isOpen = TRUE;
	return TRUE;
}

-(BOOL)openOrCreate:(NSString*)name mode:(NSInteger)mode {
	if (mode != FILE_MODE_PRIVATE) {
		lastError = ERR_INVALID_PARAM;
		lastErrorMessage = @"Only FILE_MODE_PRIVATE is supported for iOS.";
		return FALSE;
	}
	
	return [self open:name];
}
-(BOOL)close {
	if (!isOpen) return FALSE;
	
	sqlite3_close(db);
	
	isOpen = FALSE;
	return TRUE;
}
-(BOOL)deleteDatabase:(NSString*)name {
	NSString* path = [self getPath:name];
	NSFileManager* manager = [NSFileManager defaultManager];
	if ([manager fileExistsAtPath:path]) {
		NSError* error = nil;
		[manager removeItemAtPath:path error:&error];
		if (error) {
			self.lastError = ERR_FILE_OPEN;
			self.lastErrorMessage = [error localizedDescription];
			return FALSE;
		}
	} else {
		self.lastError = ERR_FILE_OPEN;
		self.lastErrorMessage = @"Database file does not found.";
		return FALSE;
	}
	return TRUE;
}

-(BOOL)openOrCreatePreference {
	BOOL result = [self openOrCreate:@DEFAULT_DATABASE_NAME mode:FILE_MODE_PRIVATE];
	if (!result) return FALSE;
	
	char* sql = sqlite3_mprintf("CREATE TABLE IF NOT EXISTS %q (KEY TEXT PRIMARY KEY, VALUE TEXT)", PREFERENCE_TABLE_NAME);
	int rcode = [self exec:sql];
	sqlite3_free(sql);
	
	return rcode == SQLITE_OK;
}

-(BOOL)openPreference {
	return [self open:@DEFAULT_DATABASE_NAME];
}

-(NSString*)getPreference:(NSString*)key {
	BOOL forceClose = FALSE;
	
	if (!isOpen) {
		[self openOrCreatePreference];
		forceClose = TRUE;
	}
	
	NSString* value;
	char* sql = sqlite3_mprintf("SELECT VALUE FROM %q WHERE KEY=%Q", PREFERENCE_TABLE_NAME, [key UTF8String]);
	
	char* error;
	int rcode = sqlite3_exec(db, sql, database_preference_callback, &value, &error);
	if (rcode != SQLITE_OK) {
		self.lastError = rcode;
		self.lastErrorMessage = char2ns(error);
		sqlite3_free(error);
	}
	sqlite3_free(sql);
	
	if (forceClose) {
		[self close];
	}
	return value;
}
-(BOOL)setPreference:(NSString*) key value:(NSString*)value {
	BOOL forceClose = FALSE;
	if (!isOpen) {
		[self openOrCreatePreference];
		forceClose = TRUE;
	}
	
	NSInteger count;
	char *csql = sqlite3_mprintf("SELECT COUNT(*) FROM %q WHERE KEY=%Q", PREFERENCE_TABLE_NAME, [key UTF8String]);
	[self exec_count:csql count:&count];
	sqlite3_free(csql);
	
	int rcode = SQLITE_OK;
	if (count == 0) {
		char* sql = sqlite3_mprintf("INSERT INTO %q(KEY,VALUE) VALUES(%Q,%Q)", PREFERENCE_TABLE_NAME, [key UTF8String], [value UTF8String]);
		rcode = [self exec:sql];
		sqlite3_free(sql);
	} else {
		char* sql = sqlite3_mprintf("UPDATE %q SET VALUE=%Q WHERE KEY=%Q", PREFERENCE_TABLE_NAME, [value UTF8String], [key UTF8String]);
		rcode = [self exec:sql];
		sqlite3_free(sql);
	}
	
	if (forceClose) {
		[self close];
	}
	
	return rcode == SQLITE_OK;
}
-(NSArray*)getPreferenceKeys {
	BOOL forceClose = FALSE;
	if (!isOpen) {
		[self openOrCreatePreference];
		forceClose = TRUE;
	}
	
	NSMutableArray* keys = [NSMutableArray array];
	char *sql = sqlite3_mprintf("SELECT KEY FROM %q", PREFERENCE_TABLE_NAME);
	[self query_vector:sql values:keys];
	sqlite3_free(sql);
	
	if (forceClose) {
		[self close];
	}
	return keys;
}
-(BOOL)deletePreference:(NSString*)key {
	BOOL forceClose = FALSE;
	if (!isOpen) {
		[self openOrCreatePreference];
		forceClose = TRUE;
	}
	
	char *sql = sqlite3_mprintf("DELETE FROM %q WHERE KEY=%Q", PREFERENCE_TABLE_NAME, [key UTF8String]);
	int rcode = [self exec:sql];
	sqlite3_free(sql);
	
	if (forceClose) {
		[self close];
	}
	return rcode == SQLITE_OK;
}
-(NSInteger)getLastError {
	return lastError;
}

-(NSString*)getLastErrorMessage {
	return lastErrorMessage;
}

-(NSString*)getPath:(NSString*)name {
	NSString* docDir = [NSSearchPathForDirectoriesInDomains(
			NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	return [NSString stringWithFormat:@"%@/%@", docDir, name];
}

@end
