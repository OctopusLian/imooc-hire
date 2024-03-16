
import request from '@/utils/request'

export function getDataDictList(params) {
    return request({
        url: '/dataDict/list',
        method: 'post',
        params: params
    })
}

export function createDataDict(dataDict) {
    return request({
        url: '/dataDict/create',
        method: 'post',
        data: dataDict
    })
}

export function deleteDataDict(params) {
    return request({
        url: '/dataDict/delete',
        method: 'post',
        params: params
    })
}

export function getDataDictItem(params) {
    return request({
        url: '/dataDict/item',
        method: 'post',
        params: params
    })
}

export function updateDataDict(dataDict) {
    return request({
        url: '/dataDict/modify',
        method: 'post',
        data: dataDict
    })
}


