
import request from '@/utils/request'

export function login(data) {
    return request({
        url: '/admin/login',
        method: 'post',
        data
    })
}

export function login2(data) {
    return request({
        url: '/vue-admin-template/user/login',
        method: 'post',
        data
    })
}

export function getInfo(token) {
    return request({
        url: '/admin/info',
        method: 'get',
        params: { token }
    })
}

export function getInfo2(token) {
    return request({
        url: '/vue-admin-template/user/info',
        method: 'get',
        params: { token }
    })
}

export function logout(token) {
    return request({
        url: '/admin/logout',
        method: 'post',
        params: { token }
    })
}

export function logout2() {
    return request({
        url: '/vue-admin-template/user/logout',
        method: 'post'
    })
}
