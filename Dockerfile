FROM golang as builder
ADD . /go/modbus_exporter
WORKDIR /go/modbus_exporter
RUN make build

FROM debian:10-slim
WORKDIR /app
COPY --from=builder /go/modbus_exporter/modbus_exporter .
COPY --from=builder /go/modbus_exporter/modbus.yml .
ENTRYPOINT ["./modbus_exporter"]
EXPOSE 9602
EXPOSE 9011
