chrome.runtime.onInstalled.addListener(() => {
  void chrome.storage.local.set({
    resolve_extension_version: "0.1.0",
  });
});
