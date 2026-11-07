# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Flutter Deferred Components & Play Core
-dontwarn com.google.android.play.core.**

# Razorpay SDK
-keepattributes *Annotation*
-dontwarn com.razorpay.**
-keep class com.razorpay.** {*;}
-optimizations !class/loading/findclass,!class/merging/*

# Google Mobile Ads
-keep public class com.google.android.gms.ads.** {
   public *;
}

# Supabase and Postgrest
-dontwarn org.apache.http.**
-dontwarn android.net.http.**
