
import request from '@/utils/request'

export function getTopList() {
    return request({
        url: '/jobType/getTopList',
        method: 'get'
    })
}

export function getChildrenJobTypeList(id) {
    return request({
        url: '/jobType/children/' + id,
        method: 'get',
    })
}

export function createNode(data) {
    return request({
        url: '/jobType/createNode',
        method: 'post',
        data
    })
}

export function updateNode(data) {
    return request({
        url: '/jobType/updateNode',
        method: 'post',
        data
    })
}

export function deleteNode(id) {
    return request({
        url: '/jobType/deleteNode/' + id,
        method: 'delete',
    })
}
