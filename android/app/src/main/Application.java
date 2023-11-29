package com.example.fakebook; // Thay thế bằng tên gói thực tế của ứng dụng của bạn

import android.app.Application;
import androidx.multidex.MultiDex;

public class MyApplication extends Application {
    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        MultiDex.install(this);
    }
}
