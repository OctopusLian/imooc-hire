
import request from '@/utils/request'


export function queryMyResume(userId) {
    return request({
        url: '/resume/queryMyResume?userId=' + userId,
        method: 'post',
    })
}

export function getHrList(bo) {
    return request({
        url: '/userinfo/saas/hrList?page=' + bo.page + "&limit=" + bo.limit,
        method: 'post',
        data: bo
    })
}

export function getCompanyList(bo) {
    return request({
        url: '/company/admin/getCompanyList?page=' + bo.page + "&limit=" + bo.limit,
        method: 'post',
        data: bo
    })
}

export function getItemsByKeys(bo) {
    return request({
        url: '/dataDict/app/getItemsByKeys',
        method: 'post',
        data: bo
    })
}

export function getPhotos() {
    return request({
        url: '/company/saas/getPhotos',
        method: 'post',
    })
}

export function getCompanyInfo() {
    return request({
        url: '/company/saas/moreInfo',
        method: 'post',
    })
}

export function doReview(bo) {
    return request({
        url: '/company/admin/doReview',
        method: 'post',
        data: bo
    })
}

export function getInterviewList(params) {
    return request({
        url: '/interview/list',
        method: 'post',
        params: params
    })
}

export function getCompanyJobList(params) {
    return request({
        url: '/job/jobList',
        method: 'post',
        params: params
    })
}

export function getJobInfo(params) {
    return request({
        url: '/job/admin/jobDetail',
        method: 'post',
        params: params
    })
}

export function isVip() {
    return request({
        url: '/company/saas/isVip',
        method: 'post',
    })
}



export function resetPwd(resetBO) {
    return request({
        url: '/admininfo/resetPwd',
        method: 'post',
        data: resetBO
    })
}

export function deleteAdmin(params) {
    return request({
        url: '/admininfo/delete',
        method: 'post',
        params: params
    })
}


export function updateMyInfo(updateAdminBO) {
    return request({
        url: '/admininfo/updateMyInfo',
        method: 'post',
        data: updateAdminBO
    })
}


