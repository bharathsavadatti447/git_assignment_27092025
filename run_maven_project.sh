#!/bin/bash
# ----------------------------------------------------------------
# run_maven_project.sh
# Script to compile, test, and generate JaCoCo coverage for a Maven project
# Supports custom source directory
# ----------------------------------------------------------------

# Exit immediately if any command fails
set -e

# Customize this path if your Java files are in a subfolder
CUSTOM_SRC_DIR="."

echo "======================================"
echo "Running Maven build with custom source directory: $CUSTOM_SRC_DIR"
echo "======================================"

# Clean and compile
mvn clean compile -Dproject.build.sourceDirectory="$CUSTOM_SRC_DIR"

# Run tests
echo "Running tests..."
mvn test -Dproject.build.sourceDirectory="$CUSTOM_SRC_DIR"

# Generate JaCoCo report
echo "Generating JaCoCo coverage report..."
mvn jacoco:report -Dproject.build.sourceDirectory="$CUSTOM_SRC_DIR"

echo "======================================"
echo "Maven build, tests, and JaCoCo report completed successfully!"
echo "======================================"
