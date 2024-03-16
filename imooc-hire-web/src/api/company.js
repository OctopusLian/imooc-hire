
import request from '@/utils/request'

export function getItemsByKeys(bo) {
    return request({
        url: '/dataDict/app/getItemsByKeys',
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

export function getCompanyInfo(params) {
    return request({
        url: '/company/admin/getCompanyInfo',
        method: 'post',
        params: params
    })
}

export function doReview(bo) {
    return request({
        url: '/company/admin/doReview',
        method: 'post',
        data: bo
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


