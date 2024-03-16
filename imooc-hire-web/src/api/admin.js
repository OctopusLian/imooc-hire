
import request from '@/utils/request'

export function getAdminList(params) {
    return request({
        url: '/admininfo/list',
        method: 'post',
        params: params
    })
}

export function createAdmin(adminBO) {
    return request({
        url: '/admininfo/create',
        method: 'post',
        data: adminBO
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

export function myInfo() {
    return request({
        url: '/admininfo/myInfo',
        method: 'post',
    })
}

export function updateMyInfo(updateAdminBO) {
    return request({
        url: '/admininfo/updateMyInfo',
        method: 'post',
        data: updateAdminBO
    })
}


