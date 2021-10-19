# wizardly-zhukovsky

Johnny Huynh - Lead DevOps Engineer @ crypto.com

## Access Log Analytics

You are given an access log file (access.log.gz) containing some requests.
Please prepare 3 shell script files as follows: (Note: any shell script executable on the
modern Linux environment, pure shell like sh, bash, csh, zsh are preferred)

1. Count the total number of HTTP requests recorded by this access logfile
2. Find the top 10 hosts that made the most requests from `2019-06-10 00:00:00` up to
and including `2019-06-19 23:59:59`
3. Find the country that made the most requests *(hint: use the source IP address as a
start)*

### Usage

Run the following commands to get answers to the first assessment.

`bash` will be the required script runtime.

We're git ignoring the `access.log` file granted that's fairly large at 18 MB. However, we'll be using `gunzip` to uncompress the provided `.gz` file.

```bash
# Get the total count of requests
./total-number.sh

# Find the top 10 hosts
./top-10-hosts.sh

# Find the country that made the most requests
./country-most-requests.sh
```

### References

https://stackoverflow.com/questions/12457457/count-number-of-lines-in-terminal-output
https://unix.stackexchange.com/questions/156261/unzipping-a-gz-file-without-removing-the-gzipped-file
https://unix.stackexchange.com/questions/360273/a-command-to-do-bulk-ip-address-lookups-using-unix-command-line-works-on-a-unix/360284
https://stackoverflow.com/questions/2034799/how-to-truncate-long-matching-lines-returned-by-grep-or-ack
https://unix.stackexchange.com/questions/83473/get-my-country-by-ip-in-bash

## System Design

We are designing a simple bit.ly-like service (API only), which includes two web API endpoints,
as follows:

### Web API endpoint for url submission

`POST` `/newurl`

#### Request

```json
{ "url": "https://www.google.com" }
```

#### Response

```json
{ "url": "https://www.google.com", "shortenUrl": "https://shortenurl.org/g20hi3k9"}
```

### Web API endpoint for redirecting a shortened URL to the real URL

Note: The shortened link cannot be modified once created)

`GET` `/[a-zA-Z0-9]{9}` (RegEx, eg. g20hi3k9t)

HTTP 302 redirection to the real URL

### System Design Concerns

- High availability : Please make it highly available and no single point  of failure.
- Scalability : Please make it scalable.
- Scaling target : 1000+ req/s, after scaling-up/out without major code change

### Tech Stack

- You can choose any technology, database, cache, as long as it can run on a generic 
Linux system

### Deliverables

- Format: PDF, markdown, plain text
- Architecture Diagram (No need to be too fancy, a simple drawing or handwritten scans
are fine)
- Database schema
- Pseudo code
- CI/CD software and design considerations For each component, e.g. database, cache,
programming language -- explain your choice and why
- State any assumptions/limitations of the design

