buildscript {
    val kotlin_version by extra("1.9.0")
    repositories {
        google()
        jcenter()
        mavenCentral()
    }

    dependencies {
        classpath("com.android.tools.build:gradle:8.4.1") // Android Gradle Plugin
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version")
        classpath("com.google.gms:google-services:4.3.14") // if using Firebase
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }

    subprojects {
        
        // Set namespace automatically if missing
        afterEvaluate {

            if (plugins.hasPlugin("com.android.application") || plugins.hasPlugin("com.android.library")) {
                dependencies {
                    "implementation"("androidx.core:core-ktx:1.12.0")
                }
            }

            extensions.findByName("android")?.let { androidExt ->
                (androidExt as? com.android.build.gradle.BaseExtension)?.apply {
                    if (namespace == null) namespace = project.group.toString()
                }
            }
        }
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
