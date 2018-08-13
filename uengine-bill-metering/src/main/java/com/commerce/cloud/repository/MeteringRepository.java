package com.commerce.cloud.repository;

import com.commerce.cloud.model.MeteringLog;
import com.commerce.cloud.model.UsageLog;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.elasticsearch.ElasticsearchException;
import org.elasticsearch.action.DocWriteResponse;
import org.elasticsearch.action.bulk.BulkItemResponse;
import org.elasticsearch.action.bulk.BulkRequest;
import org.elasticsearch.action.bulk.BulkResponse;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.action.index.IndexResponse;
import org.elasticsearch.client.RestHighLevelClient;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
import java.util.UUID;
//import org.springframework.data.elasticsearch.repository.ElasticsearchCrudRepository;
//import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;
//
//public interface MeteringRepository extends ElasticsearchCrudRepository<MeteringLog, String> {
//
//}

@Repository
public class MeteringRepository {

    private final String METERING_TYPE = "metering";
    private final String USAGE_TYPE = "usage";
    private RestHighLevelClient restHighLevelClient;
    private ObjectMapper objectMapper;

    public MeteringRepository(ObjectMapper objectMapper, RestHighLevelClient restHighLevelClient) {
        this.objectMapper = objectMapper;
        this.restHighLevelClient = restHighLevelClient;
    }

    public List<MeteringLog> insertMeteringLog(List<MeteringLog> logs) {
        BulkRequest bulkRequest = new BulkRequest();
        for (MeteringLog log : logs) {
            log.setId(UUID.randomUUID().toString());
            Map dataMap = objectMapper.convertValue(log, Map.class);

            IndexRequest indexRequest = new IndexRequest(METERING_TYPE, METERING_TYPE, log.getId())
                    .source(dataMap);
            bulkRequest.add(indexRequest);
        }

        try {
            BulkResponse bulk = restHighLevelClient.bulk(bulkRequest);
            BulkItemResponse[] items = bulk.getItems();
            System.out.println("");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return logs;
    }

    public List<UsageLog> insertUsageLog(List<UsageLog> logs) {
        BulkRequest bulkRequest = new BulkRequest();
        for (UsageLog log : logs) {
            log.setId(UUID.randomUUID().toString());
            Map dataMap = objectMapper.convertValue(log, Map.class);

            IndexRequest indexRequest = new IndexRequest(USAGE_TYPE, USAGE_TYPE, log.getId())
                    .source(dataMap);
            bulkRequest.add(indexRequest);
        }

        try {
            BulkResponse bulk = restHighLevelClient.bulk(bulkRequest);
            BulkItemResponse[] items = bulk.getItems();
            System.out.println("");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return logs;
    }
}
