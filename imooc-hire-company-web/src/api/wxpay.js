
import request from '@/utils/request'

export function getWXPayQRCode(merchantOrderId) {
    return request({
        url: '/tradeOrder/generatorWXPayQRCode?merchantOrderId=' + merchantOrderId,
        method: 'post'
    })
}

export function createTradeOrder() {
    return request({
        url: '/tradeOrder/create',
        method: 'post'
    })
}

export function getOrderList(bo) {
    return request({
        url: '/tradeOrder/list?page=' + bo.page + "&limit=" + bo.limit,
        method: 'post'
    })
}

