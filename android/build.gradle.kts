import com.android.build.gradle.BaseExtension

allprojects {
    repositories {
        google()
        mavenCentral()
        maven {
            url = uri("https://maven.pkg.github.com/cctip/aflib")
            credentials {
                username = findProperty("gpr_user") as String
                password = findProperty("gpr_key") as String
            }
        }
        maven {
            url = uri("https://maven.pkg.github.com/cctip/v2ray")
            credentials {
                username = findProperty("gpr_user") as String
                password = findProperty("gpr_key") as String
            }
        }
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
    project.gradle.afterProject {
        val android = project.properties["android"] as BaseExtension?
        if (android != null && android.namespace == null) {
            println(" ${project.name} namespace is null chane to ${project.group}")
            android.namespace = project.group.toString()
        }
    }
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
