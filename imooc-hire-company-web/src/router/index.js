
import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

/* Layout */
import Layout from '@/layout'

/**
 * Note: sub-menu only appear when route children.length >= 1
 * Detail see: https://panjiachen.github.io/vue-element-admin-site/guide/essentials/router-and-nav.html
 *
 * hidden: true                   if set true, item will not show in the sidebar(default is false)
 * alwaysShow: true               if set true, will always show the root menu
 *                                if not set alwaysShow, when item has more than one children route,
 *                                it will becomes nested mode, otherwise not show the root menu
 * redirect: noRedirect           if set noRedirect will no redirect in the breadcrumb
 * name:'router-name'             the name is used by <keep-alive> (must set!!!)
 * meta : {
    roles: ['admin','editor']    control the page roles (you can set multiple roles)
    title: 'title'               the name show in sidebar and breadcrumb (recommend set)
    icon: 'svg-name'/'el-icon-x' the icon show in the sidebar
    breadcrumb: false            if set false, the item will hidden in breadcrumb(default is true)
    activeMenu: '/example/list'  if set path, the sidebar will highlight the path you set
}
 */

/**
 * constantRoutes
 * a base page that does not have permission requirements
 * all roles can be accessed
 */
export const constantRoutes = [
    {
        path: '/login',
        component: () => import('@/views/login/index'),
        hidden: true
    },

    {
        path: '/404',
        component: () => import('@/views/404'),
        hidden: true
    },

    {
        path: '/pdf/download',
        component: () => import('@/views/recruit/downloadPDF'),
        hidden: true
    },

    {
        path: '/resume/download',
        component: () => import('@/views/candidate/downloadResume'),
        hidden: true
    },

    {
        path: '/',
        component: Layout,
        redirect: '/dashboard',
        children: [{
            path: 'dashboard',
            name: 'Dashboard',
            component: () => import('@/views/dashboard/index'),
            meta: { title: '控制面板', icon: 'dashboard' }
        }]
    },

    {
        path: '/company',
        component: Layout,
        redirect: '/company/info',
        name: 'companyMng',
        meta: { title: '企业信息 ', icon: 'el-icon-coordinate' },
        children: [
            {
                path: 'info',
                name: 'info',
                component: () => import('@/views/company/info'),
                meta: { title: '企业信息', icon: 'el-icon-office-building' }
            },
        ]
    },

    {
        path: '/orders',
        component: Layout,
        redirect: '/orders/vip',
        name: 'articleMng',
        meta: { title: '订单管理', icon: 'el-icon-document' },
        children: [
            {
                path: 'vip',
                name: 'vip',
                component: () => import('@/views/order/vip'),
                meta: { title: 'VIP充值', icon: 'el-icon-star-on' }
            },
            {
                path: 'list',
                name: 'list',
                component: () => import('@/views/order/list'),
                meta: { title: '交易订单', icon: 'el-icon-box' }
            },
            {
                path: 'error',
                name: 'error',
                component: () => import('@/views/order/error'),
                meta: { title: '失败页面', icon: 'el-icon-error' },
                hidden: true
            },
            {
                path: 'paying',
                name: 'paying',
                component: () => import('@/views/order/paying'),
                meta: { title: '支付页面', icon: 'el-icon-info' },
                hidden: true
            },
            {
                path: 'wxpay',
                name: 'wxpay',
                component: () => import('@/views/order/wxpay'),
                meta: { title: '微信支付', icon: 'el-icon-info' },
                hidden: true
            },
        ]
    },



    {
        path: '/recruit',
        component: Layout,
        redirect: '/recruit/jobs',
        name: 'recruitMng',
        meta: { title: '招聘管理', icon: 'el-icon-setting' },
        children: [
            {
                path: 'hrList',
                name: 'hrList',
                component: () => import('@/views/hr/list'),
                meta: { title: '招聘人员', icon: 'el-icon-s-custom' }
            },
            {
                path: 'jobs',
                name: 'jobs',
                component: () => import('@/views/recruit/jobs'),
                meta: { title: '历史职位', icon: 'el-icon-s-opportunity' }
            },
            {
                path: 'candidate',
                name: 'candidate',
                component: () => import('@/views/candidate/list'),
                meta: { title: '面试记录', icon: 'el-icon-s-custom' }
            },
        ]
    },

    // {
    //     path: '/hr',
    //     component: Layout,
    //     redirect: '/hr/list',
    //     children: [{
    //         path: 'hrList',
    //         name: 'hrList',
    //         component: () => import('@/views/hr/list'),
    //         meta: { title: '招聘人员', icon: 'el-icon-s-custom' }
    //     }]
    // },

    // {
    //     path: '/form',
    //     component: Layout,
    //     children: [
    //         {
    //             path: 'index',
    //             name: 'Form',
    //             component: () => import('@/views/form/index'),
    //             meta: { title: 'Form', icon: 'form' }
    //         }
    //     ]
    // },

    // {
    //     path: 'external-link',
    //     component: Layout,
    //     children: [
    //         {
    //             path: 'https://panjiachen.github.io/vue-element-admin-site/#/',
    //             meta: { title: 'External Link', icon: 'link' }
    //         }
    //     ]
    // },

    // 404 page must be placed at the end !!!
    { path: '*', redirect: '/404', hidden: true }
]

const createRouter = () => new Router({
    // mode: 'history', // require service support
    scrollBehavior: () => ({ y: 0 }),
    routes: constantRoutes
})

const router = createRouter()

// Detail see: https://github.com/vuejs/vue-router/issues/1234#issuecomment-357941465
export function resetRouter() {
    const newRouter = createRouter()
    router.matcher = newRouter.matcher // reset router
}

export default router
