package com.example.sensorapp;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


        Button start = (Button) findViewById(R.id.start);
        Button stop = (Button) findViewById(R.id.stop);
        final EditText currentActivity = (EditText) findViewById((R.id.editText));
        final EditText distance = (EditText) findViewById((R.id.editText2));

        final Intent startSensor = new Intent(MainActivity.this, SensorService.class);
        final Intent stopSensor = new Intent(MainActivity.this, SensorService.class);

        start.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {

                startSensor.putExtra("currentActivity", currentActivity.getText().toString());
                startSensor.putExtra("distance", distance.getText().toString());
                startService(startSensor);
                Toast.makeText(getApplicationContext(), "Data collection started!", Toast.LENGTH_LONG).show();
            }
        });

        stop.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {

                stopService(stopSensor);
                Toast.makeText(getApplicationContext(), "Data collection stopped!", Toast.LENGTH_LONG).show();

                Log.v("MainActivity","Service stopped");
            }
        });





    }

}
