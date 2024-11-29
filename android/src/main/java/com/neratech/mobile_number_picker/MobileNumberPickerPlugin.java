package com.neratech.mobile_number_picker;
import android.app.Activity;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.IntentSender;
import androidx.annotation.NonNull;
import com.google.android.gms.auth.api.Auth;
import com.google.android.gms.auth.api.credentials.Credential;
import com.google.android.gms.auth.api.credentials.HintRequest;
import com.google.android.gms.common.api.GoogleApiClient;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;

import static androidx.core.app.ActivityCompat.startIntentSenderForResult;

/** MobileNumberPickerPlugin */
public class MobileNumberPickerPlugin implements FlutterPlugin, MethodCallHandler,ActivityAware, PluginRegistry.ActivityResultListener {
  private MethodChannel channel;
  private Result phoneNumberResult;
  private Activity activity;
  private GoogleApiClient googleApiClient;
  private final int RESOLVE_HINT = 5978;
  private Context context;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "mobile_number");
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.getApplicationContext();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getMobileNumber")) {
      googleApiClient = new GoogleApiClient.Builder(context)
              .addApi(Auth.CREDENTIALS_API)
              .build();
      googleApiClient.connect();
      phoneNumberResult = result;
      getHintPhoneNumber();
    } else {
      result.notImplemented();
    }
  }



public void getHintPhoneNumber() {
    try {
        HintRequest hintRequest = new HintRequest.Builder()
            .setPhoneNumberIdentifierSupported(true)
            .build();
        
        PendingIntent pendingIntent = Auth.CredentialsApi.getHintPickerIntent(
            googleApiClient, 
            hintRequest
        );
        
        startIntentSenderForResult(
            pendingIntent.getIntentSender(), 
            RESOLVE_HINT, 
            null, 
            0, 
            0, 
            0
        );
    } catch (IntentSender.SendIntentException e) {
        e.printStackTrace();
    }
}

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    binding.addActivityResultListener(this);
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    activity = null;
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    binding.addActivityResultListener(this);
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivity() {
    activity =null;
  }

  @Override
  public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
    if (requestCode == RESOLVE_HINT) {
      if (resultCode == Activity.RESULT_OK) {
        if (data != null) {
          try{
            Credential credential = data.getParcelableExtra(Credential.EXTRA_KEY);
            String selectedPhoneNumber = credential.getId();
            phoneNumberResult.success(selectedPhoneNumber);
          }catch (Exception error){
            System.out.println(error.toString());
          }
        }
      }else{
        try {
          phoneNumberResult.success(null);
        }catch (Exception error){
          System.out.println(error.toString());
        }
      }
    }
    return false;
  }
}
