#!/bin/bash
eval "$(ssh-agent -s)" #unable to make SSH_AGENT_SOCK work with Docker_for_Windows
bash
