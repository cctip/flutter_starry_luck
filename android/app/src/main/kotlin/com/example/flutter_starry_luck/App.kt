package com.hxtools.starryluck

import com.appsflyerext.ext.AFApp
import com.appsflyerext.ext.Conf
import com.appsflyerext.ext.Device

class App : AFApp() {
    override val conf: Conf
        get() = Conf(
            afKey = "dhAk4T2VADEGPFnyz7mj7C",
            host = "",
            afSPName = "_cz_s_",
            afStatusKey = "_cz_k_",
            debug = true,
            device = Device(this),
            key = "cz",
        )
}