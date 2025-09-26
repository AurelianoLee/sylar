#include "util.h"

namespace sylar {
pid_t GetThreadId() {
#ifdef __APPLE__
    uint64_t tid;
    pthread_threadid_np(NULL, &tid);
    return tid;
#elif __linux__
    return syscall(SYS_gettid);
#endif
}

uint32_t GetFiberId() {
    return 0;
}

}
