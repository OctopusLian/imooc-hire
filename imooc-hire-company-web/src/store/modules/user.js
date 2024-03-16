
import { login, logout, getInfo, getQRToken, codeHasBeenRead, checkLogin } from '@/api/user'
import { getToken, setToken, removeToken } from '@/utils/auth'
import { resetRouter } from '@/router'

const getDefaultState = () => {
    return {
        token: getToken(),
        name: '',
        avatar: '',
        companyId: ''
    }
}

const state = getDefaultState()

const mutations = {
    RESET_STATE: (state) => {
        Object.assign(state, getDefaultState())
    },
    SET_TOKEN: (state, token) => {
        state.token = token
    },
    SET_NAME: (state, name) => {
        state.name = name
    },
    SET_AVATAR: (state, avatar) => {
        state.avatar = avatar
    },
    SET_COMPANY_ID: (state, companyId) => {
        state.companyId = companyId
    }
}

const actions = {

    codeHasBeenRead({ commit }, params) {
        // console.log(params);
        return new Promise((resolve, reject) => {
            codeHasBeenRead(params.qrToken).then(response => {
                const { data } = response;
                // console.log(data);
                resolve(data);
            }).catch(error => {
                console.log(error);
                reject(error)
            })
        })
    },

    checkLogin({ commit }, params) {
        // console.log(params);
        return new Promise((resolve, reject) => {
            checkLogin(params.preToken).then(response => {
                const { data } = response;
                // console.log(data);
                commit('SET_TOKEN', data)
                setToken(data)
                resolve(data);
            }).catch(error => {
                console.log(error);
                reject(error)
            })
        })
    },

    getQRToken() {
        return new Promise((resolve, reject) => {
            getQRToken().then(response => {
                const { data } = response;
                // console.log(data);
                resolve(data);
            }).catch(error => {
                console.log(error);
                reject(error)
            })
        })
    },

    // user login
    login({ commit }, userInfo) {
        // console.log(userInfo);
        const { username, password } = userInfo
        return new Promise((resolve, reject) => {
            login({ username: username.trim(), password: password }).then(response => {
                const { data } = response
                // console.log(response);
                // console.log(data);
                commit('SET_TOKEN', data)
                setToken(data)
                // commit('SET_TOKEN', data)
                // setToken(data)
                resolve()
            }).catch(error => {
                console.log(error);
                reject(error)
            })
        })
    },

    // get user info
    getInfo({ commit, state }) {
        var toeken = getToken();
        // console.log(state.token);
        return new Promise((resolve, reject) => {
            getInfo(state.token).then(response => {
                const { data } = response

                // console.log(response);
                // console.log(data);

                if (!data) {
                    return reject('Verification failed, please Login again.')
                }

                const { name, face } = data

                commit('SET_NAME', name)
                commit('SET_AVATAR', face)
                resolve(data)
            }).catch(error => {
                reject(error)
            })
        })
    },

    // user logout
    logout({ commit, state }) {
        return new Promise((resolve, reject) => {
            logout(state.token).then(() => {
                removeToken() // must remove  token  first
                resetRouter()
                commit('RESET_STATE')
                resolve()
            }).catch(error => {
                reject(error)
            })
        })
    },

    // remove token
    resetToken({ commit }) {
        return new Promise(resolve => {
            removeToken() // must remove  token  first
            commit('RESET_STATE')
            resolve()
        })
    }
}

export default {
    namespaced: true,
    state,
    mutations,
    actions
}

