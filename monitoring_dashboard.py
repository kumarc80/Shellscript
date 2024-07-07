import streamlit as st
import requests
import psutil
import os
from datetime import datetime
import logging

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Function to check URL status
def check_url_status(url):
    try:
        response = requests.get(url)
        return response.status_code
    except requests.ConnectionError as e:
        logger.error(f"Connection Error: {e}")
        return "Connection Error"

# Function to get filesystem usage
def get_filesystem_usage(path):
    try:
        usage = psutil.disk_usage(path)
        return usage
    except Exception as e:
        logger.error(f"Error getting filesystem usage: {e}")
        return None

# Function to get server status
def get_server_status():
    try:
        cpu_usage = psutil.cpu_percent(interval=1)
        memory_info = psutil.virtual_memory()
        uptime = datetime.now() - datetime.fromtimestamp(psutil.boot_time())
        return cpu_usage, memory_info, uptime
    except Exception as e:
        logger.error(f"Error getting server status: {e}")
        return None, None, None

# Streamlit app
st.title("Monitoring Dashboard")

# URL Monitoring
st.header("URL Monitoring")
urls = ["https://www.google.com", "https://www.github.com"]
url_statuses = {url: check_url_status(url) for url in urls}

for url, status in url_statuses.items():
    st.write(f"URL: {url} - Status: {status}")

# Filesystem Monitoring
st.header("Filesystem Monitoring")
filesystem_path = "/"
filesystem_usage = get_filesystem_usage(filesystem_path)

if filesystem_usage:
    st.write(f"Filesystem Path: {filesystem_path}")
    st.write(f"Total: {filesystem_usage.total / (1024 ** 3):.2f} GB")
    st.write(f"Used: {filesystem_usage.used / (1024 ** 3):.2f} GB")
    st.write(f"Free: {filesystem_usage.free / (1024 ** 3):.2f} GB")
    st.write(f"Usage: {filesystem_usage.percent}%")
else:
    st.write("Error getting filesystem usage.")

# Server Status Monitoring
st.header("Server Status Monitoring")
cpu_usage, memory_info, uptime = get_server_status()

if cpu_usage is not None:
    st.write(f"CPU Usage: {cpu_usage}%")
    st.write(f"Memory Usage: {memory_info.percent}%")
    st.write(f"Total Memory: {memory_info.total / (1024 ** 3):.2f} GB")
    st.write(f"Used Memory: {memory_info.used / (1024 ** 3):.2f} GB")
    st.write(f"Free Memory: {memory_info.free / (1024 ** 3):.2f} GB")
    st.write(f"Server Uptime: {str(uptime).split('.')[0]}")
else:
    st.write("Error getting server status.")
