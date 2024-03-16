
import request from '@/utils/request'

export function saveArticle(bo) {
    return request({
        url: '/article/save',
        method: 'post',
        data: bo
    })
}

export function deleteArticle(id) {
    return request({
        url: '/article/delete?articleId=' + id,
        method: 'post',
    })
}

export function openArticle(id) {
    return request({
        url: '/article/open?articleId=' + id,
        method: 'post',
    })
}

export function getArticleDetail(id) {
    return request({
        url: '/article/detail?articleId=' + id,
        method: 'post',
    })
}

export function getArticleList(bo) {
    return request({
        url: '/article/list?page=' + bo.page + "&limit=" + bo.limit,
        method: 'post',
    })
}

export function uploadFiles(formData) {
    return request({
        url: '/file/uploadArticleImages',
        method: 'post',
        data: formData,
        headers: {'Content-Type': 'multipart/form-data'}
    })
}

export function uploadCover(formData) {
    return request({
        url: '/file/uploadArticleCover',
        method: 'post',
        data: formData,
        headers: {'Content-Type': 'multipart/form-data'}
    })
}

export function fetchList(query) {
    return request({
        url: '/vue-element-admin/article/list',
        method: 'get',
        params: query
    })
}

export function fetchArticle(id) {
    return request({
        url: '/vue-element-admin/article/detail',
        method: 'get',
        params: {
            id
        }
    })
}

export function fetchPv(pv) {
    return request({
        url: '/vue-element-admin/article/pv',
        method: 'get',
        params: {
            pv
        }
    })
}

export function createArticle(data) {
    return request({
        url: '/vue-element-admin/article/create',
        method: 'post',
        data
    })
}

export function updateArticle(data) {
    return request({
        url: '/vue-element-admin/article/update',
        method: 'post',
        data
    })
}
