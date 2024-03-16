
import request from '@/utils/request'

export function getCompanyInfo() {
    return request({
        url: '/company/info',
        method: 'post',
    })
}
