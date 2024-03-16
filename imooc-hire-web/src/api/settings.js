
import request from '@/utils/request'

export function getMaxRefreshResumeCounts() {
    return request({
        url: '/sys/params',
        method: 'post'
    })
}

export function modifyMaxResumeRefreshCounts(params) {
    return request({
        url: '/sys/modifyMaxResumeRefreshCounts',
        method: 'post',
        params: params
    })
}
