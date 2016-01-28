{
    "id": "dsra/remove-qntfy-running-containers", 
    "cmd": "chmod u+x remove-qntfy-running-containers.sh && ./remove-qntfy-running-containers.sh",
    "cpus": 1,
    "mem": 10.0,
    "instances": 11,
    "constraints": [["hostname", "UNIQUE"]],
    "uris": [
        "http://hub.dsra.local:8088/dsra/repo/scripts/remove-qntfy-running-containers.sh"
    ]
}
