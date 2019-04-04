package com.example.sensorapp;

import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.AsyncTask;
import android.os.Environment;
import android.os.IBinder;
import android.provider.Settings;
import android.util.Log;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class SensorService extends Service implements SensorEventListener {


    private SensorManager mSensorManager;
    private Sensor mSensor;

    public File dir; // Define dir and make sure it exists
    int count;

    List<String> bufferedData;
    List<String> writeBuffer;

    CurrentState currState = CurrentState.getInstance();

    Boolean isAccelerometer = false;
    Boolean isGravity = false;
    Boolean isPressure = false;
    Boolean isGyro = false;
    Boolean isLinearAcceleration = false;
    Boolean isMagnetometer = false;
    Boolean isRotation = false;
    Boolean isOrientation = false;
    Boolean isLight = false;

    Sensor mAccelerometer;
    Sensor mMagnetometer;
    Sensor mGravity;
    Sensor mPressure;
    Sensor mGyroscope;
    Sensor mLight;
    Sensor mLinearAcceleration;
    Sensor mRotation;
    Sensor mOrientation;

    String timestamp = null;
    String androidID;
    String currentActivity;
    String distance;
    String filename;
    private int interval = 100000;
    private SensorEventListener mSensorEventListener;




    public SensorService() {
    }

    @Override
    public IBinder onBind(Intent intent) {
        // TODO: Return the communication channel to the service.
        throw new UnsupportedOperationException("Not yet implemented");
    }


    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {

    }

    public String getFileName(String currentActivity, String distance) {
        //SimpleDateFormat sdf = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
        SimpleDateFormat sdf = new SimpleDateFormat("dd-mm-yy_hh:mm:ss");

        String currentDateandTime = sdf.format(new Date());
        String filename = currentActivity+ "_" + currentDateandTime + "_"+ distance+ ".csv";

        return filename;
    }

    public int onStartCommand(Intent intent, int flags, int startId)
    {
        filename = null;
        Log.v("SensorService: ", "Sensor Service started!");

        if(intent != null)
        {
            currentActivity = intent.getStringExtra("currentActivity");
            distance = intent.getStringExtra("distance");

        }
        else
        {
            Log.v("SensorService: ", "Sensor Service intent is empty");
            //getFileName();
        }

        filename = getFileName(currentActivity, distance);

        Log.v("OnStartCommand: ", "writing to " + dir + "/" + filename);

        if(mSensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)!= null)
        {
            //Accelerometer is present
            isAccelerometer=true;
            mAccelerometer = mSensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
            mSensorManager.registerListener(this, mAccelerometer, interval);

        }
        else
        {
            //Accelerometer is not present
            isAccelerometer=false;

        }
        if (mSensorManager.getDefaultSensor(Sensor.TYPE_GRAVITY) != null){
            isGravity = true;
            mGravity = mSensorManager.getDefaultSensor(Sensor.TYPE_GRAVITY);
            mSensorManager.registerListener(this, mGravity, interval);
        }
        else {
            isGravity=false;
        }
        if (mSensorManager.getDefaultSensor(Sensor.TYPE_PRESSURE) != null){
            isPressure = true;
            mPressure = mSensorManager.getDefaultSensor(Sensor.TYPE_PRESSURE);
            mSensorManager.registerListener(this, mPressure, interval);
        }
        else {

            isPressure=false;
        }
        if (mSensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE) != null){
            isGyro = true;
            mGyroscope = mSensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE);
            mSensorManager.registerListener(this, mGyroscope, interval);
        }
        else {
            isGyro = false;
        }
        if (mSensorManager.getDefaultSensor(Sensor.TYPE_LINEAR_ACCELERATION) != null){
            isLinearAcceleration=true;
            mLinearAcceleration = mSensorManager.getDefaultSensor(Sensor.TYPE_LINEAR_ACCELERATION);
            mSensorManager.registerListener(this, mLinearAcceleration, interval);
        }
        else {
            isLinearAcceleration = false;
        }
        if (mSensorManager.getDefaultSensor(Sensor.TYPE_MAGNETIC_FIELD) != null){
            isMagnetometer = true;
            mMagnetometer = mSensorManager.getDefaultSensor(Sensor.TYPE_MAGNETIC_FIELD);
            mSensorManager.registerListener(this, mMagnetometer, interval);
        }
        else {
            isMagnetometer = false;
        }
        if (mSensorManager.getDefaultSensor(Sensor.TYPE_ROTATION_VECTOR) != null){
            isRotation = true;
            mRotation = mSensorManager.getDefaultSensor(Sensor.TYPE_ROTATION_VECTOR);
            mSensorManager.registerListener(this, mRotation, interval);
        }
        else {
            isRotation= false;
        }
        if (mSensorManager.getDefaultSensor(Sensor.TYPE_ORIENTATION) != null){
            isOrientation = true;
            mOrientation = mSensorManager.getDefaultSensor(Sensor.TYPE_ORIENTATION);
            mSensorManager.registerListener(this, mOrientation, interval);
        }
        else {
            isOrientation= false;
        }
        if (mSensorManager.getDefaultSensor(Sensor.TYPE_LIGHT) != null){
            isLight = true;
            mLight = mSensorManager.getDefaultSensor(Sensor.TYPE_LIGHT);
            mSensorManager.registerListener(this, mLight, interval);
        }
        else {
            isLight=false;
        }

        mSensorEventListener = this;
        count=0;

        Log.v("SensorService", "----- Writing New Sensor File ---- ");


        //truncateSDFile();
        writeToSDFile("timestamp, acc_x, acc_y, acc_z, gyro_x, gyro_y, gyro_z, mag_x, mag_y, mag_z, light, la_x, la_y, la_z, gravity_x, gravity_y, gravity_z, pressure, rot_x, rot_y, rot_z, azimuth, pitch, roll, sensor_change");


        return START_REDELIVER_INTENT;
    }

    @Override
    public void onSensorChanged(SensorEvent event)
    {

        //Log.v("SensorService", "onSensorChanged");

        Sensor sensor = event.sensor;
        if (sensor.getType() == Sensor.TYPE_ACCELEROMETER)
        {
            currState.acc_x = event.values[0];
            currState.acc_y = event.values[1];
            currState.acc_z = event.values[2];


        }
        else if(sensor.getType() == Sensor.TYPE_GRAVITY)
        {
            currState.gravity_x = event.values[0];
            currState.gravity_y = event.values[1];
            currState.gravity_z = event.values[2];


        }
        else if(sensor.getType() == Sensor.TYPE_GYROSCOPE)
        {
            currState.gyro_x = event.values[0];
            currState.gyro_y = event.values[1];
            currState.gyro_z = event.values[2];

        }
        else if(sensor.getType() == Sensor.TYPE_ROTATION_VECTOR)
        {

            currState.rot_x = event.values[0];
            currState.rot_y = event.values[1];
            currState.rot_z = event.values[2];
            /*
            //currState.rot_z = event.values[3];
            //currState.rot_z = event.values[4];
            float rotationMatrix[] =new float[9];
            mSensorManager.getRotationMatrixFromVector(rotationMatrix,event.values);
            float[] orientationValues = new float[3];
            SensorManager.getOrientation(rotationMatrix, orientationValues);
            currState.orietantion_azimuth = (int) Math.toDegrees(orientationValues[0] + 180)%360;
            currState.orietantion_pitch = Math.toDegrees(orientationValues[1]);
            currState.orietantion_roll = Math.toDegrees(orientationValues[2]);
            */

            float[] orientation = new float[3];
            float[] rMat = new float[9];
            // calculate th rotation matrix
            SensorManager.getRotationMatrixFromVector( rMat, event.values );
            // get the azimuth value (orientation[0]) in degree
            currState.orietantion_azimuth = (int) ( Math.toDegrees( SensorManager.getOrientation( rMat, orientation )[0] ) + 360 ) % 360;
            currState.orietantion_pitch = Math.toDegrees( SensorManager.getOrientation( rMat, orientation )[1]);
            currState.orietantion_roll = Math.toDegrees( SensorManager.getOrientation( rMat, orientation )[2]);



        }
        else if(sensor.getType() == Sensor.TYPE_MAGNETIC_FIELD)
        {
            currState.mag_x = event.values[0];
            currState.mag_y = event.values[1];
            currState.mag_z = event.values[2];

        }
        else if(sensor.getType() == Sensor.TYPE_LIGHT)
        {
            currState.light = event.values[0]; //Ambient light level in SI lux units

        }
        else if(sensor.getType() == Sensor.TYPE_LINEAR_ACCELERATION)
        {
            currState.la_x = event.values[0];
            currState.la_y = event.values[1];
            currState.la_z = event.values[2];

        }
        else if(sensor.getType() == Sensor.TYPE_PRESSURE)
        {
            currState.pressure = event.values[0]; //Atmospheric pressure in hPa (millibar)

        }

        //SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
        //SimpleDateFormat sdf = new SimpleDateFormat("dd-mm-yy_hh:mm:ss");

        //timestamp = sdf.format(new Date());

        timestamp = Long.toString(System.currentTimeMillis());

        String data = timestamp + ", " +
                Double.toString((currState.acc_x)) + ", " + Double.toString((currState.acc_y)) + ", " + Double.toString((currState.acc_z))
                + ", " + Double.toString((currState.gyro_x)) + ", " + Double.toString((currState.gyro_y)) + ", " + Double.toString((currState.gyro_z))
                + ", " + Double.toString((currState.mag_x)) + ", " +Double.toString((currState.mag_y)) + ", " +Double.toString((currState.mag_z))
                + ", " + Double.toString((currState.light))
                + ", " + Double.toString((currState.la_x)) + ", " + Double.toString((currState.la_y)) + ", "+ Double.toString((currState.la_z))
                + ", " + Double.toString((currState.gravity_x)) + ", " +Double.toString((currState.gravity_y)) + ", " +Double.toString((currState.gravity_z))
                + ", " + Double.toString((currState.pressure))
                + ", " + Double.toString((currState.rot_x)) + ", " +Double.toString((currState.rot_y))+ ", " +Double.toString((currState.rot_z))
                + ", " + Double.toString((currState.orietantion_azimuth))+ ", " +Double.toString((currState.orietantion_pitch)) +  ", " +Double.toString((currState.orietantion_roll))
                + ", " + event.sensor.getName();

        Log.v("SensorService------", event.sensor.getName());
        if(count == 1000)
        {
            Log.v("SensorService", "5000 lines reached");
            writeBuffer = new ArrayList<String>(bufferedData);
            bufferedData.clear();
            count =0;
            new WriteFile().execute();


        }
        else
        {
            bufferedData.add((data));
        }
        count++;
    }

    private class WriteFile extends AsyncTask<Void, Void, Void>
    {
        @Override
        protected void onPostExecute(Void aVoid) {
            //super.onPostExecute(aVoid);
            Log.v("SensorService", "Data logged");
        }

        @Override
        protected Void doInBackground(Void... params) {
            //Log.v("SensorService", "Size of write buffer: " + writeBuffer.size());
            writeToSDFile();
            writeBuffer.clear();

            return null;

        }
    }

    private void writeToSDFile(String d){

        File file = new File(dir + File.separator + filename);
        FileOutputStream fOut = null;
        try {
            fOut = new FileOutputStream(file, true);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        OutputStreamWriter osw = new OutputStreamWriter(fOut);
        try {
            osw.write(d + "\n");
            osw.flush();
            osw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    private void writeToSDFile(){

        Log.v("SensorService", "Size of write buffer: " + writeBuffer.size());


        File file = new File(dir + File.separator + filename);
        FileOutputStream fOut = null;
        try {
            fOut = new FileOutputStream(file, true);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        OutputStreamWriter osw = new OutputStreamWriter(fOut);
        try {
            for(int i=0;i<writeBuffer.size(); i++) {
                osw.write(writeBuffer.get(i) + "\n");
            }
            osw.flush();
            osw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }


    public void onCreate()
    {
        super.onCreate();
        bufferedData = new ArrayList<String>();
        mSensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);
        List<Sensor> deviceSensors = mSensorManager.getSensorList(Sensor.TYPE_ALL);

        File root = android.os.Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS);
        Log.v("Downloads Path", root.getAbsolutePath());
        dir = new File (root.getAbsolutePath() + File.separator);

        //Log.v(" ****** Sensors:", deviceSensors.toString());
    }
    public void onDestroy() {
        super.onDestroy();
        new WriteFile().execute();
        Log.v("SensorService", "Ending");

    }
}
