import com.android.build.gradle.AppExtension
import com.android.build.gradle.LibraryExtension

plugins {
    id("com.android.library") apply false
}

/// Same revision as [FlutterExtension.ndkVersion] in the Flutter SDK; keeps
/// `:app` and native plugins (e.g. `:fvp`) on one NDK so a bad `sdk/ndk/*`
/// tree cannot fail configuration (CXX1101 / missing source.properties).
private val aurorNdkVersion = "28.2.13676358"

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
    project.plugins.withId("com.android.library") {
        project.extensions.configure<LibraryExtension>("android") {
            ndkVersion = aurorNdkVersion
        }
    }
    project.plugins.withId("com.android.application") {
        project.extensions.configure<AppExtension>("android") {
            ndkVersion = aurorNdkVersion
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
