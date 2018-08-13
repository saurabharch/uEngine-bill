package com.commerce.cloud.billing;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
public class Usage {
    String subscriptionId;
    List<UnitUsageRecord> unitUsageRecords;

    @Data
    @NoArgsConstructor
    public static class UnitUsageRecord {
        String unitType;
        List<UsageRecord> usageRecords;

        @Data
        @NoArgsConstructor
        public static class UsageRecord {
            String recordDate;
            int amount;
        }
    }
}
