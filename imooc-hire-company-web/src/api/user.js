
import request from '@/utils/request'

export function getQRToken() {
    return request({
        url: '/saas/getQRToken',
        method: 'post'
    })
}

export function codeHasBeenRead(qrToken) {
    return request({
        url: '/saas/codeHasBeenRead?qrToken=' + qrToken,
        method: 'post'
    })
}

export function checkLogin(preToken) {
    return request({
        url: '/saas/checkLogin?preToken=' + preToken,
        method: 'post'
    })
}

export function login(data) {
    return request({
        url: '/saas/login',
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
        url: '/saas/info',
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
        url: '/saas/logout',
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
