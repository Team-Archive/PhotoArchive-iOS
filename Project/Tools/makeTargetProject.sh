#!/bin/bash

# 사용법 안내 함수
usage() {
  echo "Usage: $0 <FeatureName> <TargetDirectory>"
  exit 1
}

# Feature 이름과 Target 디렉토리를 입력받습니다.
FEATURE_NAME=$1
TARGET_DIR=$2

# 입력값 검증
if [ -z "$FEATURE_NAME" ] || [ -z "$TARGET_DIR" ]; then
  usage
fi

# 디렉토리 생성
mkdir -p $TARGET_DIR/$FEATURE_NAME/Resources
mkdir -p $TARGET_DIR/$FEATURE_NAME/SampleApp/Resources
mkdir -p $TARGET_DIR/$FEATURE_NAME/SampleApp/Sources
mkdir -p $TARGET_DIR/$FEATURE_NAME/Sources/Internal
mkdir -p $TARGET_DIR/$FEATURE_NAME/Sources/Public
mkdir -p $TARGET_DIR/$FEATURE_NAME/TestHost/Resources
mkdir -p $TARGET_DIR/$FEATURE_NAME/TestHost/Sources
mkdir -p $TARGET_DIR/$FEATURE_NAME/Tests/Extension

# tmp.swift 파일 생성
touch $TARGET_DIR/$FEATURE_NAME/Resources/tmp.swift
touch $TARGET_DIR/$FEATURE_NAME/SampleApp/Resources/tmp.swift
touch $TARGET_DIR/$FEATURE_NAME/SampleApp/Sources/tmp.swift
touch $TARGET_DIR/$FEATURE_NAME/Sources/Internal/tmp.swift
touch $TARGET_DIR/$FEATURE_NAME/Sources/Public/tmp.swift
touch $TARGET_DIR/$FEATURE_NAME/TestHost/Resources/tmp.swift
touch $TARGET_DIR/$FEATURE_NAME/TestHost/Sources/tmp.swift
touch $TARGET_DIR/$FEATURE_NAME/Tests/Extension/tmp.swift

# Project.swift 파일 생성
cat <<EOF > $TARGET_DIR/$FEATURE_NAME/Project.swift
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
  name: "$FEATURE_NAME",
  frameworkDependencies: [

  ],
  testDependencies: []
)
EOF

# SampleApp.swift 파일 생성
cat <<EOF > $TARGET_DIR/$FEATURE_NAME/SampleApp/Sources/SampleApp.swift
import SwiftUI
import Domain

@main
struct SampleApp: App {
  var body: some Scene {
    WindowGroup {

    }
  }
}
EOF

# Assets.xcassets 디렉토리 생성
mkdir -p $TARGET_DIR/$FEATURE_NAME/SampleApp/Resources/Assets.xcassets

echo "$FEATURE_NAME 프로젝트가 $TARGET_DIR 에 생성되었습니다."

