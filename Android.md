```java
timetask定时任务scheduleAtFixedRate       //任务开始几秒后判断上一个任务是否执行结束，结束则下一个任务，否则继续执行上一个任务
timetask延时任务scheduleWithFixedDelay    //上一个任务执行结束几秒后执行
```

```java
不要再函数行打断点，因为JPDA的原因会一直运行导致调试卡顿
```

```java
ServiceConnectio类作为绑定服务类，需要在AndroidManifest里注册的服务，也就是Service,类似
<service
            android:name="com.xingkom.facerecognize.service.OfflineLanService"
            android:enabled="true"
            android:exported="false" />
```

```java
//测试手机 红米K30S
//这行代码相当于是弹框获取权限，只是在AndroidmaniFest配置的话有时是获取不到相应的权限的
if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (checkSelfPermission(Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED) {
                requestPermissions(new String[] {Manifest.permission.CAMERA}, 1);
            }
        }

//以下是获取可用的相机有哪些，工业板卡的话有Camera.CameraInfo.CAMERA_FACING_BACK和CAMERA_FACING_FRONT这两个摄像头。有时候在工业板卡中这两个都是前置摄像头
//在安卓手机中，如果正常获取的摄像头无法使用可以尝试使用以上两个。Back是后置摄像头，Front是前置摄像头
        int cameraId = -1;
        int numberOfCameras = Camera.getNumberOfCameras();
        for (int i = 0; i <= numberOfCameras; i++) {
            Camera.CameraInfo info = new Camera.CameraInfo();
            Camera.getCameraInfo(i, info);
            if (info.facing == Camera.CameraInfo.CAMERA_FACING_FRONT) {
                cameraId = i;
                break;
            }
        }
        myCamera = Camera.open(Camera.CameraInfo.CAMERA_FACING_BACK);
//*****************************************************************************************
//开启闪光灯的方法，必须要使用Camera.CameraInfo.CAMERA_FACING_BACK，使用前置摄像头的话会闪退或者报错error 2
    try {
    Camera.Parameters mParameters = myCamera.getParameters();
    mParameters.setFlashMode(Camera.Parameters.FLASH_MODE_TORCH);
    myCamera.setPreviewTexture(new SurfaceTexture(0));//这行必须要，没有这行就没办法开启闪光灯
    myCamera.setParameters(mParameters);
    myCamera.startPreview();
    } catch (IOException e) {
        throw new RuntimeException(e);
    }
//*****************************************************************************************
//关闭闪光灯
    Camera.Parameters mParameters = myCamera.getParameters();
    mParameters.setFlashMode(Camera.Parameters.FLASH_MODE_OFF);
    myCamera.setParameters(mParameters);
```

```java
//将activity修改为雷士dialog的样式
//在style.xml创建风格，然后将风格在androidmanifest设置在activity上就可以了。
//Example
<style name="dialog_style" parent="Theme.AppCompat.Light.Dialog">
        <!--是否悬浮在activity上-->
        <item name="android:windowIsFloating">true</item>
        <!--透明是否-->
        <item name="android:windowIsTranslucent">true</item>
        <item name="android:layout_width">700dp</item>
        <item name="android:layout_height">500dp</item>
        <!--设置没有窗口标题、dialog标题等各种标题-->
        <item name="android:windowNoTitle">true</item>
        <item name="windowNoTitle">true</item>
        <!--点击 dialog Activity 周围是否关闭弹窗 true 关闭（默认为true） false 为不关闭-->
        <item name="android:windowCloseOnTouchOutside">false</item>
    </style>
```
