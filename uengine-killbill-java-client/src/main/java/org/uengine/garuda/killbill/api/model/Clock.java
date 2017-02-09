package org.uengine.garuda.killbill.api.model;

import org.joda.time.DateTime;
import org.joda.time.format.ISODateTimeFormat;
import org.uengine.garuda.util.JsonUtils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

/**
 * Created by uengine on 2017. 2. 9..
 */
public class Clock {
    Date currentUtcTime;
    String timeZone;
    String localDate;

    public Clock() {
    }

    public Clock(Map map) {
        String currentUtcTime = map.get("currentUtcTime").toString();
        //SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");

        DateTime dateTime = ISODateTimeFormat.dateTimeParser().parseDateTime(currentUtcTime);
        try {
            this.currentUtcTime = dateTime.toDate();
            this.timeZone = map.get("timeZone").toString();
            this.localDate = map.get("localDate").toString();
        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }
    }

    public Date getCurrentUtcTime() {
        return currentUtcTime;
    }

    public void setCurrentUtcTime(Date currentUtcTime) {
        this.currentUtcTime = currentUtcTime;
    }

    public String getTimeZone() {
        return timeZone;
    }

    public void setTimeZone(String timeZone) {
        this.timeZone = timeZone;
    }

    public String getLocalDate() {
        return localDate;
    }

    public void setLocalDate(String localDate) {
        this.localDate = localDate;
    }
}
