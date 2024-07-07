#!/bin/bash

echo "Setting up Prometheus and Grafana..."

# Download and install Prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.30.3/prometheus-2.30.3.linux-amd64.tar.gz
tar xvfz prometheus-2.30.3.linux-amd64.tar.gz
cd prometheus-2.30.3.linux-amd64

# Start Prometheus server
./prometheus --config.file=prometheus.yml &

# Download and install Grafana
wget https://dl.grafana.com/oss/release/grafana-8.1.5.linux-amd64.tar.gz
tar -zxvf grafana-8.1.5.linux-amd64.tar.gz
cd grafana-8.1.5

# Start Grafana server
./bin/grafana-server &

echo "Prometheus and Grafana setup completed."
