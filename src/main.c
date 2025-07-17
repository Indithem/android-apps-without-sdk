/*
 * The name of the lib file generated and
 * the name of the function that will be first called
 * can be changed by changing Manifest file
 *
```xml
<activity android:name="android.app.NativeActivity"
           android:label="@string/app_name"
           android:configChanges="orientation|keyboardHidden">
     <meta-data android:name="android.app.lib_name"     # name of lib
                android:value="my_game_lib" />
     <meta-data android:name="android.app.func_name"    # name of function to call
                android:value="my_game_entry" />
</activity>
```
 */

void android_main() {
    /*
     * Right now this errors with
     07-17 23:31:17.982 10355 10355 E AndroidRuntime: FATAL EXCEPTION: main
     07-17 23:31:17.982 10355 10355 E AndroidRuntime: Process: com.example.nopurpose, PID: 10355
     07-17 23:31:17.982 10355 10355 E AndroidRuntime: java.lang.RuntimeException: Unable to start activity ComponentInfo{com.example.nopurpose/android.app.NativeActivity}: java.lang.IllegalArgumentException: Unable to find native library main using classloader: dalvik.system.PathClassLoader[DexPathList[[],nativeLibraryDirectories=[/data/app/~~rvaR0_tgk4sIWBQlqpguIw==/com.example.nopurpose-QWmX7ImBOkBiIk1bV4tOYg==/lib/x86_64, /system/lib64, /system/system_ext/lib64, /system/product/lib64]]]
     07-17 23:31:17.982 10355 10355 E AndroidRuntime: 	at android.app.ActivityThread.performLaunchActivity(ActivityThread.java:3645)
     07-17 23:31:17.982 10355 10355 E AndroidRuntime: 	at android.app.ActivityThread.handleLaunchActivity(ActivityThread.java:3782)
     07-17 23:31:17.982 10355 10355 E AndroidRuntime: 	at android.app.servertransaction.LaunchActivityItem.execute(LaunchActivityItem.java:101)
     07-17 23:31:17.982 10355 10355 E AndroidRuntime: 	at android.app.servertransaction.TransactionExecutor.executeCallbacks(TransactionExecutor.java:138)
     07-17 23:31:17.982 10355 10355 E AndroidRuntime: 	at android.app.servertransaction.TransactionExecutor.execute(TransactionExecutor.java:95)
     07-17 23:31:17.982 10355 10355 E AndroidRuntime: 	at android.app.ActivityThread$H.handleMessage(ActivityThread.java:2307)
     07-17 23:31:17.982 10355 10355 E AndroidRuntime: 	at android.os.Handler.dispatchMessage(Handler.java:106)
     07-17 23:31:17.982 10355 10355 E AndroidRuntime: 	at android.os.Looper.loopOnce(Looper.java:201)
     07-17 23:31:17.982 10355 10355 E AndroidRuntime: 	at android.os.Looper.loop(Looper.java:288)
     07-17 23:31:17.982 10355 10355 E AndroidRuntime: 	at android.app.ActivityThread.main(ActivityThread.java:7924)
     07-17 23:31:17.982 10355 10355 E AndroidRuntime: 	at java.lang.reflect.Method.invoke(Native Method)
     07-17 23:31:17.982 10355 10355 E AndroidRuntime: 	at com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:548)
     07-17 23:31:17.982 10355 10355 E AndroidRuntime: 	at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:937)
     07-17 23:31:17.982 10355 10355 E AndroidRuntime: Caused by: java.lang.IllegalArgumentException: Unable to find native library main using classloader: dalvik.system.PathClassLoader[DexPathList[[],nativeLibraryDirectories=[/data/app/~~rvaR0_tgk4sIWBQlqpguIw==/com.example.nopurpose-QWmX7ImBOkBiIk1bV4tOYg==/lib/x86_64, /system/lib64, /system/system_ext/lib64, /system/product/lib64]]]
     07-17 23:31:17.982 10355 10355 E AndroidRuntime: 	at android.app.NativeActivity.onCreate(NativeActivity.java:164)
     07-17 23:31:17.982 10355 10355 E AndroidRuntime: 	at android.app.Activity.performCreate(Activity.java:8365)
     07-17 23:31:17.982 10355 10355 E AndroidRuntime: 	at android.app.Activity.performCreate(Activity.java:8344)
     07-17 23:31:17.982 10355 10355 E AndroidRuntime: 	at android.app.Instrumentation.callActivityOnCreate(Instrumentation.java:1417)
     07-17 23:31:17.982 10355 10355 E AndroidRuntime: 	at android.app.ActivityThread.performLaunchActivity(ActivityThread.java:3626)
     07-17 23:31:17.982 10355 10355 E AndroidRuntime: 	... 12 more
     07-17 23:31:18.257   565   992 E OpenGLRenderer: Device claims wide gamut support, cannot find matching config, error = EGL_SUCCESS
     */
}

/*
 * This function is purely needed so that I can get `zig cc` to work.
 * Are there any work arounds???
 */
int main() {}
