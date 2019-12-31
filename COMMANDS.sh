#!/bin/bash

echo "******************************************************************************************************************"
echo "Reference links"
https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html
https://github.com/ruanbekker/elasticsearch-demo
https://gist.github.com/ruanbekker/e8a09604b14f37e8d2f743a87b930f93

echo "******************************************************************************************************************"
echo "Single docker for quick start"
docker pull docker.elastic.co/elasticsearch/elasticsearch:7.5.1
docker run -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.5.1

echo "******************************************************************************************************************"
echo "Multi node cluster docker compose"
docker-compose -f docker-master.yml up
docker-compose -f docker-master.yml ps
docker-compose -f docker-master.yml down

docker-compose -f docker-node.yml up --scale es-node=3
docker-compose -f docker-node.yml ps
docker-compose -f docker-node.yml down

docker-compose -f docker-kibana.yml up --scale es-kibana=2
docker-compose -f docker-kibana.yml ps
docker-compose -f docker-kibana.yml down

echo "******************************************************************************************************************"
echo "Check cluster health"
curl -X GET "localhost:9200/_cat/nodes?v&pretty"
curl -X GET "localhost:9200?pretty"

echo "******************************************************************************************************************"
echo "Create index"
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

echo "******************************************************************************************************************"
echo "Add document to index"
curl -XPUT 'http://localhost:9200/employee/_create/1' -H 'Content-Type: application/json' -d '
{ 
    "user": "name1", 
    "postDate": "2019-12-30", 
    "body": "body1",
    "title": "title1"
}
'
curl -X GET "localhost:9200/employee/_count?pretty"

