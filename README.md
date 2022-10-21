# Heimdall Enhanced App to display Epson XP-900 printer ink levels

This Heimdall Enhanced App could display the ink level for an Epson XP-900 or any other printer.

## Requirements

- Cron job to run ink-check.sh
- Promteheus Pushgateway to store the recorded values

## Setup

1) Get Prometheus with pushgateway
2) Fill in the printer and pushgateway addresses in ink-check.sh
3) add ink-check.sh to a cron job
4) Add this app as a Private Heimdall App
5) Set up the pushgateway api url in heimdall