import java.util.Base64

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// dart-define を入れる変数を宣言しています。
val dartDefines = mutableMapOf<String, String>()
if (project.hasProperty("dart-defines")) {
    val dartDefinesProperty = project.property("dart-defines") as String
    dartDefinesProperty.split(",").forEach { entry ->
        val pair = String(Base64.getDecoder().decode(entry)).split("=")
        if (pair.size == 2) {
            dartDefines[pair[0]] = pair[1]
        }
    }
}

tasks.register<Copy>("copySources") {
    from("src/${dartDefines["flavor"]}/res")
    into("src/main/res")
}

tasks.whenTaskAdded {
    dependsOn("copySources")
}

android {
    namespace = "com.example.flutter_launcher_icons_study"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.flutter_launcher_icons_study"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
