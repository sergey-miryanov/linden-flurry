#ifndef LINDEN_FLURRY_H_581ed32e_8b49_41bd_b47c_ff2bd0ca1626
#define LINDEN_FLURRY_H_581ed32e_8b49_41bd_b47c_ff2bd0ca1626

namespace LindenFlurry
{
  void setCrashReportingEnabled(bool enabled);
  void startSession(const char* key);

  void logEvent(const char* eventId, bool timed);
  void logEvent(const char* eventId, int keysCount,
      const char** keys, const char** values,
      bool timed);
  void endTimedEvent(const char* eventId);
  void endTimedEvent(const char* eventId, int keysCount,
      const char** keys, const char** values);
}

#endif
