#pragma once
#include <cstdint>
#include <unordered_map>
#include <vector>
#include <string>
#include <sys/stat.h>
#include <sys/socket.h>
#include <poll.h>
#include <map>
#include <mutex>

#include "Tests/LinuxSyscalls/EmulatedFiles/EmulatedFiles.h"

namespace FEXCore::Context {
struct Context;
}

namespace FEX::HLE {

class FileManager final {
public:
  FileManager() = delete;
  FileManager(FileManager &&) = delete;

  FileManager(FEXCore::Context::Context *ctx);
  ~FileManager();
  uint64_t Open(const char *pathname, int flags, uint32_t mode);
  uint64_t Close(int fd);
  uint64_t Stat(const char *pathname, void *buf);
  uint64_t Lstat(const char *path, void *buf);
  uint64_t Access(const char *pathname, int mode);
  uint64_t FAccessat(int dirfd, const char *pathname, int mode);
  uint64_t FAccessat2(int dirfd, const char *pathname, int mode, int flags);
  uint64_t Readlink(const char *pathname, char *buf, size_t bufsiz);
  uint64_t Chmod(const char *pathname, mode_t mode);
  uint64_t Readlinkat(int dirfd, const char *pathname, char *buf, size_t bufsiz);
  uint64_t Openat(int dirfs, const char *pathname, int flags, uint32_t mode);
  uint64_t Statx(int dirfd, const char *pathname, int flags, uint32_t mask, struct statx *statxbuf);
  uint64_t Mknod(const char *pathname, mode_t mode, dev_t dev);
  uint64_t NewFSStatAt(int dirfd, const char *pathname, struct stat *buf, int flag);
  uint64_t NewFSStatAt64(int dirfd, const char *pathname, struct stat64 *buf, int flag);

  // vfs
  uint64_t Statfs(const char *path, void *buf);

  std::string *FindFDName(int fd);
  std::string GetEmulatedPath(const char *pathname);

private:
  FEX::EmulatedFile::EmulatedFDManager EmuFD;

  std::mutex FDLock;
  std::unordered_map<int32_t, std::string> FDToNameMap;
  std::string PidSelfPath;
  std::map<std::string, std::string> ThunkOverlays;

  FEX_CONFIG_OPT(Filename, APP_FILENAME);
  FEX_CONFIG_OPT(LDPath, ROOTFSPATH);
  FEX_CONFIG_OPT(ThunkHostLibs, THUNKHOSTLIBSPATH);
  FEX_CONFIG_OPT(ThunkGuestLibs, THUNKGUESTLIBSPATH);
  FEX_CONFIG_OPT(ThunkConfig, THUNKCONFIGPATH);
};
}
