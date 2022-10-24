# Pulsar Demos for Tech at Scale Meetup

[24th October, 2022 meetup](https://www.meetup.com/tech-at-scale-toronto-meetup/events/288527055/)

The repo has the following demos:

1- **Basics** installing standalone pulsar locally, simple producer (java) and consumer (python), then benchmark command

2- **Function** simple pulsar function to manipulate stream data

3- **Sql** explore stored data in the topic using Pulsar SQL directly without a DB

4- **Schema** Publish data using JSONSchema and demo DelayedDelivery

## Get Started

The fastest way to get all dependencies for the project is to enter a `nix-shell` which will install all required dependencies (except Pulsar).

If you do not have it, you can easily [install nix](https://nixos.wiki/wiki/Nix_Installation_Guide) on Linux or Mac

```shell
nix develop

# for older versions, run instead
# nix-shell
```

Each folder has a README.md with instruction to run the demos in order
