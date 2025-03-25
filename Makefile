.PHONY: all clean get gen env-gen apk-test test-run

all: gen build-apk

clean:
	flutter clean -v

get:
	flutter pub get -v

gen:
	flutter pub run build_runner build --delete-conflicting-outputs

env-gen:
	dart_define generate

apk-test:
	flutter build apk --release --dart-define-from-file=env/test.json -v

test-run:
	flutter test
