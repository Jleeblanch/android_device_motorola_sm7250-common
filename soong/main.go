package sm7250

import (
    "android/soong/android"
)

func init() {
    android.RegisterModuleType("motorola_sm7250_init_library_static", initLibraryFactory)
}
