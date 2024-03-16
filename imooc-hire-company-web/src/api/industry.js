
import request from '@/utils/request'

export function getTopList() {
    return request({
        url: '/industry/getTopList',
        method: 'get'
    })
}

export function getChildrenIndustryList(id) {
    return request({
        url: '/industry/children/' + id,
        method: 'get',
    })
}

export function createNode(data) {
    return request({
        url: '/industry/createNode',
        method: 'post',
        data
    })
}

export function updateNode(data) {
    return request({
        url: '/industry/updateNode',
        method: 'post',
        data
    })
}

export function deleteNode(id) {
    return request({
        url: '/industry/deleteNode/' + id,
        method: 'delete',
    })
}
