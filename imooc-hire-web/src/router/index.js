
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

    // {
    //     path: '/example',
    //     component: Layout,
    //     redirect: '/example/table',
    //     name: 'Example',
    //     meta: { title: 'Example', icon: 'el-icon-s-help' },
    //     children: [
    //         {
    //             path: 'table',
    //             name: 'Table',
    //             component: () => import('@/views/table/index'),
    //             meta: { title: 'Table', icon: 'table' }
    //         },
    //         {
    //             path: 'tree',
    //             name: 'Tree',
    //             component: () => import('@/views/tree/index'),
    //             meta: { title: 'Tree', icon: 'tree' }
    //         }
    //     ]
    // },

    {
        path: '/article',
        component: Layout,
        redirect: '/article/list',
        name: 'articleMng',
        meta: { title: '文章管理', icon: 'el-icon-document' },
        children: [
            {
                path: 'create',
                name: 'create',
                component: () => import('@/views/article/create'),
                meta: { title: '发布文章', icon: 'el-icon-edit-outline' }
            },
            {
                path: 'list',
                name: 'list',
                component: () => import('@/views/article/list'),
                meta: { title: '文章列表', icon: 'el-icon-tickets' }
            },
            {
                path: 'edit',
                name: 'edit',
                component: () => import('@/views/article/edit'),
                meta: { title: '修改文章', icon: 'el-icon-edit-outline' },
                hidden: true

            },
        ]
    },

    {
        path: '/company',
        component: Layout,
        redirect: '/company/check',
        name: 'companyMng',
        meta: { title: '企业管理', icon: 'el-icon-coordinate' },
        children: [
            {
                path: 'check',
                name: 'check',
                component: () => import('@/views/company/list'),
                meta: { title: '企业审核', icon: 'el-icon-office-building' }
            },
            {
                path: 'industry',
                name: 'industry',
                component: () => import('@/views/company/industry'),
                meta: { title: '行业类别', icon: 'el-icon-suitcase-1' }
            },
            {
                path: 'job',
                name: 'job',
                component: () => import('@/views/company/job'),
                meta: { title: '职位类别', icon: 'el-icon-s-custom' }
            },
            {
                path: 'report',
                name: 'report',
                component: () => import('@/views/company/report'),
                meta: { title: '职位举报', icon: 'el-icon-service' }
            }
        ]
    },

    {
        path: '/admin',
        component: Layout,
        redirect: '/admin/account',
        name: 'adminMng',
        meta: { title: '运营管理', icon: 'el-icon-setting' },
        children: [
            {
                path: 'account',
                name: 'account',
                component: () => import('@/views/admin/list'),
                meta: { title: '账号分配', icon: 'el-icon-user' }
            },
            {
                path: 'dataDict',
                name: 'dataDict',
                component: () => import('@/views/dataDict/list'),
                meta: { title: '数据字典', icon: 'el-icon-notebook-2' }
            },
            {
                path: 'benefit',
                name: 'benefit',
                component: () => import('@/views/benefit/list'),
                meta: { title: '福利设置', icon: 'el-icon-milk-tea' }
            },
            {
                path: 'options',
                name: 'options',
                component: () => import('@/views/options/settings'),
                meta: { title: '参数配置', icon: 'el-icon-s-operation' }
            }
        ]
    },

    {
        path: '/my',
        component: Layout,
        redirect: '/my/info',
        children: [{
            path: 'info',
            name: 'info',
            component: () => import('@/views/my/info'),
            meta: { title: '我的信息', icon: 'el-icon-user' }
        }]
    },

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
