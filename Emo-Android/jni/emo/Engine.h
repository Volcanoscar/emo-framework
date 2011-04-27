#ifndef EMO_ENGINE_H
#define EMO_ENGINE_H

#include <android_native_app_glue.h>
#include <android/sensor.h>

#include <hash_map>
#include <sys/timeb.h>
#include <EGL/egl.h>
#include <GLES/gl.h>
#include "squirrel.h"

#include "Constants.h"
#include "Types.h"
#include "Stage.h"
#include "Drawable.h"
#include "Drawable_glue.h"
#include "Audio.h"
#include "Database.h"
#include "JavaGlue.h"

namespace emo {
    class Engine {

    public:
        Engine();
        ~Engine();

        int32_t event_handle_input(android_app* app, AInputEvent* event);
        void    event_handle_cmd(android_app* app, int32_t cmd);

        int32_t onInitDisplay();
        void    onInitGLSurface();

        void onInitEngine();
        void onDispose();

        void onTerminateDisplay();

        void onDrawFrame();
        void onLostFocus();
        void onGainedFocus();
        void onLowMemory();

        int32_t getWidth();
        int32_t getHeight();

        void updateUptime();
        int32_t getLastOnDrawDelta();
        int32_t getLastOnDrawDrawablesDelta();

        int32_t onSensorEvent(ASensorEvent* event);
        int32_t onMotionEvent(android_app* app, AInputEvent* event);
        int32_t onKeyEvent(android_app* app, AInputEvent* event);

        ASensorEventQueue* getSensorEventQueue();

        void updateOptions(int value);
        void createSensors(int value);
        void enableSensor(int sensorType, int interval);
        void disableSensor(int sensorType);

        void enableOnDrawListener(bool enable);
        void setOnDrawListenerInterval(int value);

        void addDrawable(std::string key, Drawable* drawable);
        void addDrawableToRemove(std::string key, Drawable* drawable);
        bool removeDrawable(std::string key);
        bool freeDrawable(std::string key);
        Drawable* getDrawable(std::string key);

        void onDrawDrawables();
        
        void rebindDrawableBuffers();

        void loadDrawables();
        void unloadDrawables();
        void deleteDrawableBuffers();

        int32_t getLastError();
        void setLastError(int32_t error);

        HSQUIRRELVM sqvm;

        bool animating;

        android_app* app;
        Audio* audio;
        Stage* stage;
        Database* database;
        JavaGlue* javaGlue;
        timeb uptime;

        int32_t onDrawFrameInterval;
        int32_t onDrawDrawablesInterval;

        void registerClass(HSQUIRRELVM v, const char *cname);
        void registerClassFunc(HSQUIRRELVM v, const char *cname, const char *fname, SQFUNCTION func);

        std::string getJavaPackageName();
    protected:
        bool loaded;
        bool focused;
        bool loadedCalled;
        bool initialized;
        bool scriptLoaded;

        EGLDisplay display;
        EGLSurface surface;
        EGLContext context;

        int32_t width;
        int32_t height;
        int32_t lastError;

        timeb startTime;

        float touchEventParamCache[MOTION_EVENT_PARAMS_SIZE];
        float keyEventParamCache[KEY_EVENT_PARAMS_SIZE];
        float accelerometerEventParamCache[ACCELEROMETER_EVENT_PARAMS_SIZE];

        timeb   lastOnDrawInterval;
        timeb   lastOnDrawDrawablesInterval;

        bool enablePerspectiveNicest;
        bool enableOnDrawFrame;
        bool enableBackKey;

        drawables_t* drawables;
        drawables_t* drawablesToRemove;

        ASensorManager* sensorManager;
        ASensorEventQueue* sensorEventQueue;

        const ASensor* accelerometerSensor;
        const ASensor* magneticSensor;
        const ASensor* gyroscopeSensor;
        const ASensor* lightSensor;
        const ASensor* proximitySensor;

        void initScriptFunctions();
    };
}
#endif
