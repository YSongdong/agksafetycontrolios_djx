//
//  agksafetycontrolios_djxAPI.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/8/30.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#ifndef agksafetycontrolios_djxAPI_h
#define agksafetycontrolios_djxAPI_h


#define FT_INLINE static inline
FT_INLINE  NSString  *getRequestPath(NSString *act) ;

//#ifdef DEBUG
//#define PUBLISH_DIMAIN_URL @"http://192.168.3.201:2018/"
//#else
#define PUBLISH_DIMAIN_URL @"http://api.djx.cqlanhui.com/"
//#endif

/**************获取阿里云oss上传配置参数***********/
#define HTTP_ATTAPPUPLOADOSSSINGNCONFIG_URL  getRequestPath(@"sts-server/authentication.php")


/*********检测更新***********/
#define  HTTP_ATTENDANCESYSTEMUPGRADE_URL  @"http://upgrade.cqlanhui.com/api/system/updates"
/*********首页检查用户是否有正式考试***********/
#define  HTTP_ATTAPPSERVICEAPIINDEXEXAMROOTEST_URL  getRequestPath(@"serviceapi/index/examRoomTest")
/*********操作违规上传***********/
#define  HTTP_ATTAPPMONITORSEVICEAPIFACERECOGNITIOn_URL  getRequestPath(@"serviceapi/Monitor_Service_Api/faceRecognition")
/*********首页滚动公告***********/
#define  HTTP_ATTAPPANNOUHOMEANNOU_URL  getRequestPath(@"serviceapi/annou/homeAnnou")
/*********公告列表***********/
#define  HTTP_ATTAPPSERVICEAPIANNOUALIST_URL  getRequestPath(@"serviceapi/annou/annouList")
/*********模块权限***********/
#define  HTTP_ATTAPPMODULEAUTHMODULEAUTH_URL  getRequestPath(@"serviceapi/Module_Auth/ModuleAuth")


/**************登录***********/
#define HTTP_ATTAPPLOGIN_URL  getRequestPath(@"serviceapi/Login/login")
/**************发送验证码***********/
#define HTTP_ATTAPPSendCode_URL  getRequestPath(@"serviceapi/Login/sendSms")
/**************绑定手机号***********/
#define HTTP_ATTAPPBINDINGPHONE_URL  getRequestPath(@"serviceapi/Login/bindingPhone")
/**************解绑手机***********/
#define HTTP_ATTAPPPHONEUNTIE_URL  getRequestPath(@"serviceapi/Login/Untie")
/**************修改密码***********/
#define HTTP_ATTAPPALTERPASSWORD_URL  getRequestPath(@"serviceapi/Login/userRePassword")
/**************个人资料***********/
#define HTTP_ATTAPPPERSONALCENTER_URL  getRequestPath(@"serviceapi/Login/personalCenter")
/**************忘记密码***********/
#define HTTP_ATTAPPPASSWORDRECOVERY_URL  getRequestPath(@"serviceapi/Login/passwordRecovery")
/**************人脸采集上传***********/
#define HTTP_ATTAPPFACEUPLOAD_URL  getRequestPath(@"serviceapi/Login/faceUpload")
/*********首页轮播图***********/
#define  HTTP_ATTAPPINDEXBANNER_URL getRequestPath(@"serviceapi/index/banner")

/**----------------------生成试卷------------****/
/*********开始考试-生成试卷***********/
#define  HTTP_ATTAPPPAPERGENERATEPAPER_URL getRequestPath(@"serviceapi/Paper/generatePaper")
/*********考完提交交卷***********/
#define  HTTP_ATTAPPPAPERSUBMITANSWER_URL getRequestPath(@"serviceapi/Paper/submitPaperAnswer")
/*********获取剩余秒数***********/
#define  HTTP_ATTAPPPAPERGETREMATIME_URL getRequestPath(@"serviceapi/Paper/getRemainingTime")

/**----------------------试卷练习------------****/
/*********试卷列表***********/
#define  HTTP_ATTAPPQUESTIONEXAMLIST_URL getRequestPath(@"serviceapi/Question/examList")
/*********题库/试卷筛选***********/
#define  HTTP_ATTAPPSERVICEAPIFILTEREXAM_URL getRequestPath(@"serviceapi/tag/filterExam")
/********试卷练习详情信息**********/
#define  HTTP_ATTAPPQUESTIONEXAMDETAILS_URL getRequestPath(@"serviceapi/question/examDetails")
/********考试练习人员详情**********/
#define  HTTP_ATTAPPQUESTIONEXAMUESRDETAILS_URL getRequestPath(@"serviceapi/question/examUserDetails")
/********试卷练习做题详情**********/
#define  HTTP_ATTAPPQUESTIONEXAMRECORD_URL getRequestPath(@"serviceapi/question/examRecord")
/********考试交卷后页面**********/
#define  HTTP_ATTAPPPAPEREXAMRESULTS_URL getRequestPath(@"serviceapi/paper/examResults")
/********做题中提交答案**********/
#define  HTTP_ATTAPPPPAPERRECORD_URL getRequestPath(@"serviceapi/paper/record")
/********人脸识别对比**********/
#define  HTTP_ATTAPPMOITORAPIFACERECOGINTION_URL getRequestPath(@"serviceapi/Monitor_Service_Api/faceRecognition")

/**----------------------试卷练习记录------------****/
/********练习记录**********/
#define  HTTP_ATTAPPQUESTIONMOCKLIST_URL getRequestPath(@"serviceapi/question/mockList")
/********练习记录列表**********/
#define  HTTP_ATTAPPQUESTMOCKLISTDETAILS_URL getRequestPath(@"serviceapi/question/mockListDetails")


/**----------------------正式考试------------****/
/********正式考试列表**********/
#define  HTTP_ATTAPPEXAMPAPEREXAMLIST_URL getRequestPath(@"serviceapi/exam_paper/examList")
/********考场列表**********/
#define  HTTP_ATTAPPEXAMROOMLIST_URL getRequestPath(@"serviceapi/exam_paper/examRoomList")
/********检查是否具有考试权限**********/
#define  HTTP_ATTAPPEXAMPAPEREXAMNUMBER_URL getRequestPath(@"serviceapi/exam_paper/examsNumber")
/********考试成绩**********/
#define  HTTP_ATTAPPEXAMUSERHISTORYLIST_URL getRequestPath(@"serviceapi/Exam_History/examUserHistoryList")

/**----------------------题库练习------------****/
/*********题库练习列表***********/
#define  HTTP_ATTAPPQUSTLIBARYQUESTIONLIST_URL getRequestPath(@"serviceapi/question_libary/questionList")
/*********题库详情***********/
#define  HTTP_ATTAPPQUSTLIBARYQUESTIONINFOS_URL getRequestPath(@"serviceapi/question_libary/questionLibaryInfos")
/*********专项联系详情***********/
#define  HTTP_ATTAPPQUSTLISPECIALPRACTICEINFOS_URL getRequestPath(@"serviceapi/question_libary/questionLibarySpecialPracticeInfos")
/*********清空题库练习的做题记录***********/
#define  HTTP_ATTAPPQUSTLISCLEARUSERQUESTLIBAY_URL getRequestPath(@"serviceapi/question_libary/clearUserQuestionLibary")
/*********试题收藏/取消收藏***********/
#define  HTTP_ATTAPPQUESTICOLLECTION_URL getRequestPath(@"serviceapi/question_libary/getQuestionCollection")

/**---------------------我的学习------------****/
/*********学习中心列表***********/
#define  HTTP_ATTAPPFILEMANAGEMENTLISTS_URL getRequestPath(@"serviceapi/File_Management/lists")
/*********详情***********/
#define  HTTP_ATTAPPFILEMANAGEMENTGETINFO_URL getRequestPath(@"serviceapi/File_Management/getInfo")
/*********学习时间上报***********/
#define  HTTP_ATTAPPFILEMANAGEMENTLEARECORD_URL getRequestPath(@"serviceapi/File_Management/LeaRecord")

/**----------------------消息中心------------****/
/*********消息列表***********/
#define  HTTP_ATTAPPSERVICAPIMGMAILMSGLIST_URL getRequestPath(@"serviceapi/msg_mail/msgList")
/*********获取未读消息当前数量***********/
#define  HTTP_ATTAPPMSGMAILMSGSTATISTICS_URL getRequestPath(@"serviceapi/msg_mail/msgStatistics")

/**--------------------安全检查--------------****/
/*********安全检查的配置数组***********/
#define  HTTP_ATTAPPSECURITYCHECKSETTING_URL getRequestPath(@"serviceapi/Safety_Management_Center/getSettings")
/*********安全检查添加修改***********/
#define  HTTP_ATTAPPCHANGSECURITYCHECKLISTS_URL getRequestPath(@"serviceapi/Security_Check/changeSecurityCheckLists")
/*********安全列表***********/
#define  HTTP_ATTAPPSAFETYMANAGEMENTCENTERGETLISTS_URL getRequestPath(@"serviceapi/Safety_Management_Center/getLists")
/*********安全检查详情***********/
#define  HTTP_ATTAPPSECURITYCHECKINFOS_URL getRequestPath(@"serviceapi/Security_Check/securityCheckInfos")
/*********撤销***********/
#define  HTTP_ATTAPPSAFETYMANAGEMETCENTERREVOKEIS_URL getRequestPath(@"serviceapi/Safety_Management_Center/revokeIs")

/**--------------------安全班会--------------****/
/*********安全班会记录添加修改***********/
#define  HTTP_ATTAPPCHANGECLASSRECORDLISTS_URL getRequestPath(@"serviceapi/Class_Record/changeClassRecordLists")
/*********班会记录详情***********/
#define  HTTP_ATTAPPCLASSRECORDINFOS_URL getRequestPath(@"serviceapi/Class_Record/classRecordInfos")

/**--------------------技术交底--------------****/
/*********技术交底添加修改***********/
#define  HTTP_ATTAPPCHANGETECHNICALDISCLOSURELISTS_URL getRequestPath(@"serviceapi/Technical_Disclosure/changeTechnicalDisclosureLists")
/*********技术交底详情***********/
#define  HTTP_ATTAPPTECHNICALDISCLOSUREINFOS_URL getRequestPath(@"serviceapi/Technical_Disclosure/technicalDisclosureInfos")

/**-------------------违章处理--------------****/
/*********违章处理添加修改***********/
#define  HTTP_ATTAPPCHANFWCIOLARIONHANLISTS_URL getRequestPath(@"serviceapi/Violation_Han/changeViolationHanLists")
/*********违章处理详情***********/
#define  HTTP_ATTAPPVIOLATIONHANINFOS_URL getRequestPath(@"serviceapi/Violation_Han/violationHanInfos")

/**-------------------考勤签到--------------****/
/*********查询签到人脸规则***********/
#define  HTTP_ATTAPPATTENDANCEDATAQUERY_URL getRequestPath(@"serviceapi/App_Attendance/data_query")
/*********用户签到***********/
#define  HTTP_ATTAPPATTENDANCECHECKIN_URL getRequestPath(@"serviceapi/App_Attendance/checkin")
/*********人脸识别***********/
#define  HTTP_ATTAPPATTENDANCEFACERECOGNITION_URL getRequestPath(@"serviceapi/App_Attendance/faceRecognition")
/*********签到列表***********/
#define  HTTP_ATTAPPATTENDANCEGETATTENDANCELISTS_URL getRequestPath(@"serviceapi/App_Attendance/getAttendanceLists")
/*********用户签到备注***********/
#define  HTTP_ATTAPPATTENDANCESIGNINNOTE_URL getRequestPath(@"serviceapi/App_Attendance/signinnote")

/**-------------------曝光台列表--------------****/
/*********曝光台列表***********/
#define  HTTP_ATTAPPCONTENTCENTERGETLISTS_URL getRequestPath(@"serviceapi/App_Content_Center/getLists")



/**-------------------任务中心--------------****/
/*********任务列表***********/
#define  HTTP_ATTAPPSERVICEAPIMYTASKLIST_URL getRequestPath(@"serviceapi/my_task/taskList")
/*********人员信息***********/
#define  HTTP_ATTAPPSERVICEAPIMYTASKUSERDETAILS_URL getRequestPath(@"serviceapi/my_task/userDetails")
/*********子任务列表***********/
#define  HTTP_ATTAPPSERVICEAPIMYTASKTASKCHILDLIST_URL getRequestPath(@"serviceapi/my_task/taskChildList")
/*********我的学分***********/
#define  HTTP_ATTAPPSERVICEAPIMYTASKTASKMYCREDITS_URL getRequestPath(@"serviceapi/My_Task/myCredits")
/********学分排行榜***********/
#define  HTTP_ATTAPPSERVICEAPIMYTASKTASKCREDITLEADERBOARD_URL getRequestPath(@"serviceapi/My_Task/creditLeaderboard")
/********年度排行榜***********/
#define  HTTP_ATTAPPSERVICEAPIMYTASKANNUALLEADERBOARD_URL getRequestPath(@"serviceapi/My_Task/annualLeaderboard")

/**-------------------问卷调查--------------****/
/*********问卷调查列表***********/
#define  HTTP_ATTSERICEAPIAPPQUESTIONLIST_URL getRequestPath(@"serviceapi/questionnaire/questionList")
/*********生成问卷***********/
#define  HTTP_ATTSERICEAPIGENERATEPAPER_URL getRequestPath(@"serviceapi/questionnaire/generatePaper")
/********调研中提交答案***********/
#define  HTTP_ATTSERICEAPIQUESTIONNAIRERECORD_URL getRequestPath(@"serviceapi/questionnaire/record")
/********问卷调查完全提交***********/
#define  HTTP_ATTSERICEAPISUBIMTPAPERANSWER_URL getRequestPath(@"serviceapi/questionnaire/submitPaperAnswer")
/********交卷后返回做的时间***********/
#define  HTTP_ATTSERICEAPISERVICEAPIRESEARCH_URL getRequestPath(@"serviceapi/questionnaire/research")

/**-------------------意见箱--------------****/
/*********提交意见***********/
#define  HTTP_ATTAPPSUGGESTIONBOXOPINIONSUBMISSION_URL getRequestPath(@"serviceapi/suggestion_box/OpinionSubmission")
/*********单位列表***********/
#define  HTTP_ATTSERICEAPISUGGESTIONBOXUNITLIST_URL getRequestPath(@"serviceapi/suggestion_box/unitsList")
/*********人员列表***********/
#define  HTTP_ATTSERICEAPISUGGESTIONBOXMEMBERLIST_URL getRequestPath(@"serviceapi/suggestion_box/memberList")
/*********发起的意见列表***********/
#define  HTTP_ATTSERICEAPISUGGESTIONBOXLISTBOX_URL getRequestPath(@"serviceapi/suggestion_box/listbox")
/*********回复意见列表***********/
#define  HTTP_ATTSERICEAPISUGGESTIONBOXREPLYBOX_URL getRequestPath(@"serviceapi/suggestion_box/replybox")
/*********接收但未读数量***********/
#define  HTTP_ATTSERICEAPISUGGESTIONBOXUNREAD_URL getRequestPath(@"serviceapi/suggestion_box/unread")
/*********意见箱详情***********/
#define  HTTP_ATTSERICEAPISUGGESTIONBOXOPINIONDETAILSD_URL getRequestPath(@"serviceapi/suggestion_box/OpinionDetails")
/*********消息撤回***********/
#define  HTTP_ATTSERICEAPISUGGESTIONBOXMSGWITH_URL getRequestPath(@"serviceapi/suggestion_box/msgwith")
/*********提交回复意见***********/
#define  HTTP_ATTSERICEAPISUGGESTIONBOXREPLYSUBMIT_URL getRequestPath(@"serviceapi/suggestion_box/replysubmit")

/**-------------------党员活动--------------****/
/*********党员活动列表***********/
#define  HTTP_ATTSERICEAPICOMMUNITYCOMLIST_URL getRequestPath(@"serviceapi/community/comList")
/*********发布文章***********/
#define  HTTP_ATTSERICEAPICOMMUNITYRELEASESUBMIT_URL getRequestPath(@"serviceapi/community/releaseSubmit")
/*********评论文章***********/
#define  HTTP_ATTSERICEAPICOMMUNITYREPLYSUBMIT_URL getRequestPath(@"serviceapi/community/replysubmit")
/*********文章详情***********/
#define  HTTP_ATTSERICEAPICOMMUNITYCOMDETAILS_URL getRequestPath(@"serviceapi/community/comDetails")
/*********文章评论列表***********/
#define  HTTP_ATTSERICEAPICOMMUNITYEVALUATION_URL getRequestPath(@"serviceapi/community/evaluation")
/*********点赞/取消点赞***********/
#define  HTTP_ATTSERICEAPICOMMUNITYGIVELIKE_URL getRequestPath(@"serviceapi/community/givelike")
/*********删除文章***********/
#define  HTTP_ATTSERICEAPICOMMUNITYCOMDEL_URL getRequestPath(@"serviceapi/community/comDel")
/*********文章浏览时间上报***********/
#define  HTTP_ATTSERICEAPICOMMUNITYLEARECORD_URL getRequestPath(@"serviceapi/community/LeaRecord")



/*********html 请求前缀***********/
#define  HTTP_ATTAPPWKWEBVIEWHTML_URL getRequestPath(@"")

FT_INLINE  NSString  * getRequestPath(NSString *op) {
    //修改请求地址
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSString *urlStr ;
    if ([userD objectForKey:@"IP"]) {
        NSMutableDictionary *param = [userD objectForKey:@"IP"];
        NSString *ipUserStr =param[@"IP"];
        NSString *portUserStr = param[@"port"];
        NSMutableString *ipStr = [NSMutableString string];
        if ([ipUserStr isEqualToString:@""]) {
            [ipStr appendString:PUBLISH_DIMAIN_URL];
        }else{
            [ipStr appendString:@"http://"];
            [ipStr appendString:ipUserStr];
        }
        if ([portUserStr isEqualToString:@""]) {
            if (![ipUserStr isEqualToString:@""]) {
                [ipStr appendString:@"/"];
            }
        }else{
            if (![ipUserStr isEqualToString:@""]) {
                [ipStr appendString:@":"];
                [ipStr appendString:portUserStr];
                [ipStr appendString:@"/"];
            }
        }
        urlStr = ipStr.copy;
    }else{
        urlStr = PUBLISH_DIMAIN_URL;
    }
    return [urlStr stringByAppendingFormat:@"%@",op];
}

#endif /* agksafetycontrolios_djxAPI_h */
