#!/bin/bash

docker pull docker.elastic.co/elasticsearch/elasticsearch:7.5.1
docker run -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.5.1



docker-compose up
curl -X GET "localhost:9200/_cat/nodes?v&pretty"
curl -X GET "localhost:9200?pretty"


#https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html
https://github.com/ruanbekker/elasticsearch-demo
https://gist.github.com/ruanbekker/e8a09604b14f37e8d2f743a87b930f93


curl -X DELETE "localhost:9200/*?pretty"
curl -X PUT "localhost:9200/employee?pretty" -H 'Content-Type: application/json' -d'
{
    "settings" : {
        "index" : {
            "number_of_shards" : 3, 
            "number_of_replicas" : 2 
        }
    }
}
'

curl -X GET "localhost:9200/employee/_settings?pretty"
curl -X GET "localhost:9200/_cat/indices?v&pretty"

curl -XPUT 'http://localhost:9200/employee/_create/1' -H 'Content-Type: application/json' -d '
{ 
    "user": "name1", 
    "postDate": "2019-12-30", 
    "body": "body1" ,
    "title": "title1"
}'

curl -X GET "localhost:9200/employee/_count?pretty"

