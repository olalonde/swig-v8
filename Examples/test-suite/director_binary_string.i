%module(directors="1") director_binary_string;

%feature("director") Callback;

%apply (char *STRING, size_t LENGTH) { (char *dataBufferAA, int sizeAA) };
%apply (char *STRING, size_t LENGTH) { (char *dataBufferBB, int sizeBB) };

%inline %{
#include <stdlib.h>

#define BUFFER_SIZE_AA 8
#define BUFFER_SIZE_BB 5

class Callback {
public:
  virtual ~Callback() {}
  virtual void run(char* dataBufferAA, int sizeAA, char* dataBufferBB, int sizeBB) {
    memset(dataBufferAA, -1, sizeAA);
    memset(dataBufferBB, -1, sizeBB);
  }
};

class Caller {
private:
  Callback *_callback;
public:
  Caller(): _callback(0) {}
  ~Caller() { delCallback(); }
  void delCallback() { delete _callback; _callback = 0; }
  void setCallback(Callback *cb) { delCallback(); _callback = cb; }
  int call() {
    int sum = 0;
    if (_callback) {
      char* aa = (char*)malloc(BUFFER_SIZE_AA);
      memset(aa, 9, BUFFER_SIZE_AA);
      char* bb = (char*)malloc(BUFFER_SIZE_BB);
      memset(bb, 13, BUFFER_SIZE_BB);
      _callback->run(aa, BUFFER_SIZE_AA, bb, BUFFER_SIZE_BB);
      for (int i = 0; i < BUFFER_SIZE_AA; i++)
        sum += aa[i];
      for (int i = 0; i < BUFFER_SIZE_BB; i++)
        sum += bb[i];
      free(aa);
      free(bb);
    }
    return sum;
  }
};

%}
