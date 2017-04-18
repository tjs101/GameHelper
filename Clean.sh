#!/bin/sh

#  Clean.sh
#  SimpResearch
#
#  Created by quentin on 2017/4/13.
#  Copyright © 2017年 上海美市科技有限公司. All rights reserved.

xcodebuild clean
xcodebuild | xcpretty
