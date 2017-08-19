# README


## Headers

```
[{"key":"Accept","value":"application/vnd.api+json"}]
[{"key":"Content-type","value":"application/vnd.api+json"}]
[{"key":"Authorization","value":eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MDMwODgzOTF9.M_IlivzJCrEkiSv9K8eNcGs535Zw2EL5doLM2GnOG2I"}]
```

## /api/v1/teams

```
{"data": {"type":"teams", "attributes":{"name": "Pegasus", "description": "delivery team"}}}
```

response 

```
{
    "data": {
        "id": "4",
        "type": "teams",
        "links": {
            "self": "http://localhost:3000/api/v1/teams/4"
        },
        "attributes": {
            "name": "Mercury",
            "description": "moments team"
        },
        "relationships": {
            "projects": {
                "links": {
                    "self": "http://localhost:3000/api/v1/teams/4/relationships/projects",
                    "related": "http://localhost:3000/api/v1/teams/4/projects"
                }
            }
        }
    }
}
```

## /api/v1/projects

```
{"data": {"type":"projects", "relationships":  {"team": {"data": {"type": "teams", "id": 3}}},  "attributes":{"title": "project title 3", "description": "description"}}}
```


