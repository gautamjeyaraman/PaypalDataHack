package com.bestbuy.processor.textprocessor;

/**
 * Autogenerated by Thrift Compiler (0.9.1)
 *
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 *  @generated
 */
import org.apache.thrift.scheme.IScheme;
import org.apache.thrift.scheme.SchemeFactory;
import org.apache.thrift.scheme.StandardScheme;

import org.apache.thrift.scheme.TupleScheme;
import org.apache.thrift.protocol.TTupleProtocol;
import org.apache.thrift.protocol.TProtocolException;
import org.apache.thrift.EncodingUtils;
import org.apache.thrift.TException;
import org.apache.thrift.async.AsyncMethodCallback;
import org.apache.thrift.server.AbstractNonblockingServer.*;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.EnumMap;
import java.util.Set;
import java.util.HashSet;
import java.util.EnumSet;
import java.util.Collections;
import java.util.BitSet;
import java.nio.ByteBuffer;
import java.util.Arrays;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class TextProcessor {

    public interface Iface {

        public short infer_sentiment(String DocText) throws org.apache.thrift.TException;

    }

    public interface AsyncIface {

        public void infer_sentiment(String DocText, org.apache.thrift.async.AsyncMethodCallback resultHandler) throws org.apache.thrift.TException;

    }

    public static class Client extends org.apache.thrift.TServiceClient implements Iface {
        public static class Factory implements org.apache.thrift.TServiceClientFactory<Client> {
            public Factory() {}
            public Client getClient(org.apache.thrift.protocol.TProtocol prot) {
                return new Client(prot);
            }
            public Client getClient(org.apache.thrift.protocol.TProtocol iprot, org.apache.thrift.protocol.TProtocol oprot) {
                return new Client(iprot, oprot);
            }
        }

        public Client(org.apache.thrift.protocol.TProtocol prot)
        {
            super(prot, prot);
        }

        public Client(org.apache.thrift.protocol.TProtocol iprot, org.apache.thrift.protocol.TProtocol oprot) {
            super(iprot, oprot);
        }

        public short infer_sentiment(String DocText) throws org.apache.thrift.TException
        {
            send_infer_sentiment(DocText);
            return recv_infer_sentiment();
        }

        public void send_infer_sentiment(String DocText) throws org.apache.thrift.TException
        {
            infer_sentiment_args args = new infer_sentiment_args();
            args.setDocText(DocText);
            sendBase("infer_sentiment", args);
        }

        public short recv_infer_sentiment() throws org.apache.thrift.TException
        {
            infer_sentiment_result result = new infer_sentiment_result();
            receiveBase(result, "infer_sentiment");
            if (result.isSetSuccess()) {
                return result.success;
            }
            throw new org.apache.thrift.TApplicationException(org.apache.thrift.TApplicationException.MISSING_RESULT, "infer_sentiment failed: unknown result");
        }

    }
    public static class AsyncClient extends org.apache.thrift.async.TAsyncClient implements AsyncIface {
        public static class Factory implements org.apache.thrift.async.TAsyncClientFactory<AsyncClient> {
            private org.apache.thrift.async.TAsyncClientManager clientManager;
            private org.apache.thrift.protocol.TProtocolFactory protocolFactory;
            public Factory(org.apache.thrift.async.TAsyncClientManager clientManager, org.apache.thrift.protocol.TProtocolFactory protocolFactory) {
                this.clientManager = clientManager;
                this.protocolFactory = protocolFactory;
            }
            public AsyncClient getAsyncClient(org.apache.thrift.transport.TNonblockingTransport transport) {
                return new AsyncClient(protocolFactory, clientManager, transport);
            }
        }

        public AsyncClient(org.apache.thrift.protocol.TProtocolFactory protocolFactory, org.apache.thrift.async.TAsyncClientManager clientManager, org.apache.thrift.transport.TNonblockingTransport transport) {
            super(protocolFactory, clientManager, transport);
        }

        public void infer_sentiment(String DocText, org.apache.thrift.async.AsyncMethodCallback resultHandler) throws org.apache.thrift.TException {
            checkReady();
            infer_sentiment_call method_call = new infer_sentiment_call(DocText, resultHandler, this, ___protocolFactory, ___transport);
            this.___currentMethod = method_call;
            ___manager.call(method_call);
        }

        public static class infer_sentiment_call extends org.apache.thrift.async.TAsyncMethodCall {
            private String DocText;
            public infer_sentiment_call(String DocText, org.apache.thrift.async.AsyncMethodCallback resultHandler, org.apache.thrift.async.TAsyncClient client, org.apache.thrift.protocol.TProtocolFactory protocolFactory, org.apache.thrift.transport.TNonblockingTransport transport) throws org.apache.thrift.TException {
                super(client, protocolFactory, transport, resultHandler, false);
                this.DocText = DocText;
            }

            public void write_args(org.apache.thrift.protocol.TProtocol prot) throws org.apache.thrift.TException {
                prot.writeMessageBegin(new org.apache.thrift.protocol.TMessage("infer_sentiment", org.apache.thrift.protocol.TMessageType.CALL, 0));
                infer_sentiment_args args = new infer_sentiment_args();
                args.setDocText(DocText);
                args.write(prot);
                prot.writeMessageEnd();
            }

            public short getResult() throws org.apache.thrift.TException {
                if (getState() != org.apache.thrift.async.TAsyncMethodCall.State.RESPONSE_READ) {
                    throw new IllegalStateException("Method call not finished!");
                }
                org.apache.thrift.transport.TMemoryInputTransport memoryTransport = new org.apache.thrift.transport.TMemoryInputTransport(getFrameBuffer().array());
                org.apache.thrift.protocol.TProtocol prot = client.getProtocolFactory().getProtocol(memoryTransport);
                return (new Client(prot)).recv_infer_sentiment();
            }
        }

    }

    public static class Processor<I extends Iface> extends org.apache.thrift.TBaseProcessor<I> implements org.apache.thrift.TProcessor {
        private static final Logger LOGGER = LoggerFactory.getLogger(Processor.class.getName());
        public Processor(I iface) {
            super(iface, getProcessMap(new HashMap<String, org.apache.thrift.ProcessFunction<I, ? extends org.apache.thrift.TBase>>()));
        }

        protected Processor(I iface, Map<String,  org.apache.thrift.ProcessFunction<I, ? extends  org.apache.thrift.TBase>> processMap) {
            super(iface, getProcessMap(processMap));
        }

        private static <I extends Iface> Map<String,  org.apache.thrift.ProcessFunction<I, ? extends  org.apache.thrift.TBase>> getProcessMap(Map<String,  org.apache.thrift.ProcessFunction<I, ? extends  org.apache.thrift.TBase>> processMap) {
            processMap.put("infer_sentiment", new infer_sentiment());
            return processMap;
        }

        public static class infer_sentiment<I extends Iface> extends org.apache.thrift.ProcessFunction<I, infer_sentiment_args> {
            public infer_sentiment() {
                super("infer_sentiment");
            }

            public infer_sentiment_args getEmptyArgsInstance() {
                return new infer_sentiment_args();
            }

            protected boolean isOneway() {
                return false;
            }

            public infer_sentiment_result getResult(I iface, infer_sentiment_args args) throws org.apache.thrift.TException {
                infer_sentiment_result result = new infer_sentiment_result();
                result.success = iface.infer_sentiment(args.DocText);
                result.setSuccessIsSet(true);
                return result;
            }
        }

    }

    public static class AsyncProcessor<I extends AsyncIface> extends org.apache.thrift.TBaseAsyncProcessor<I> {
        private static final Logger LOGGER = LoggerFactory.getLogger(AsyncProcessor.class.getName());
        public AsyncProcessor(I iface) {
            super(iface, getProcessMap(new HashMap<String, org.apache.thrift.AsyncProcessFunction<I, ? extends org.apache.thrift.TBase, ?>>()));
        }

        protected AsyncProcessor(I iface, Map<String,  org.apache.thrift.AsyncProcessFunction<I, ? extends  org.apache.thrift.TBase, ?>> processMap) {
            super(iface, getProcessMap(processMap));
        }

        private static <I extends AsyncIface> Map<String,  org.apache.thrift.AsyncProcessFunction<I, ? extends  org.apache.thrift.TBase,?>> getProcessMap(Map<String,  org.apache.thrift.AsyncProcessFunction<I, ? extends  org.apache.thrift.TBase, ?>> processMap) {
            processMap.put("infer_sentiment", new infer_sentiment());
            return processMap;
        }

        public static class infer_sentiment<I extends AsyncIface> extends org.apache.thrift.AsyncProcessFunction<I, infer_sentiment_args, Short> {
            public infer_sentiment() {
                super("infer_sentiment");
            }

            public infer_sentiment_args getEmptyArgsInstance() {
                return new infer_sentiment_args();
            }

            public AsyncMethodCallback<Short> getResultHandler(final AsyncFrameBuffer fb, final int seqid) {
                final org.apache.thrift.AsyncProcessFunction fcall = this;
                return new AsyncMethodCallback<Short>() {
                    public void onComplete(Short o) {
                        infer_sentiment_result result = new infer_sentiment_result();
                        result.success = o;
                        result.setSuccessIsSet(true);
                        try {
                            fcall.sendResponse(fb,result, org.apache.thrift.protocol.TMessageType.REPLY,seqid);
                            return;
                        } catch (Exception e) {
                            LOGGER.error("Exception writing to internal frame buffer", e);
                        }
                        fb.close();
                    }
                    public void onError(Exception e) {
                        byte msgType = org.apache.thrift.protocol.TMessageType.REPLY;
                        org.apache.thrift.TBase msg;
                        infer_sentiment_result result = new infer_sentiment_result();
                        {
                            msgType = org.apache.thrift.protocol.TMessageType.EXCEPTION;
                            msg = (org.apache.thrift.TBase)new org.apache.thrift.TApplicationException(org.apache.thrift.TApplicationException.INTERNAL_ERROR, e.getMessage());
                        }
                        try {
                            fcall.sendResponse(fb,msg,msgType,seqid);
                            return;
                        } catch (Exception ex) {
                            LOGGER.error("Exception writing to internal frame buffer", ex);
                        }
                        fb.close();
                    }
                };
            }

            protected boolean isOneway() {
                return false;
            }

            public void start(I iface, infer_sentiment_args args, org.apache.thrift.async.AsyncMethodCallback<Short> resultHandler) throws TException {
                iface.infer_sentiment(args.DocText,resultHandler);
            }
        }

    }

    public static class infer_sentiment_args implements org.apache.thrift.TBase<infer_sentiment_args, infer_sentiment_args._Fields>, java.io.Serializable, Cloneable, Comparable<infer_sentiment_args>   {
        private static final org.apache.thrift.protocol.TStruct STRUCT_DESC = new org.apache.thrift.protocol.TStruct("infer_sentiment_args");

        private static final org.apache.thrift.protocol.TField DOC_TEXT_FIELD_DESC = new org.apache.thrift.protocol.TField("DocText", org.apache.thrift.protocol.TType.STRING, (short)1);

        private static final Map<Class<? extends IScheme>, SchemeFactory> schemes = new HashMap<Class<? extends IScheme>, SchemeFactory>();
        static {
            schemes.put(StandardScheme.class, new infer_sentiment_argsStandardSchemeFactory());
            schemes.put(TupleScheme.class, new infer_sentiment_argsTupleSchemeFactory());
        }

        public String DocText; // required

        /** The set of fields this struct contains, along with convenience methods for finding and manipulating them. */
        public enum _Fields implements org.apache.thrift.TFieldIdEnum {
            DOC_TEXT((short)1, "DocText");

            private static final Map<String, _Fields> byName = new HashMap<String, _Fields>();

            static {
                for (_Fields field : EnumSet.allOf(_Fields.class)) {
                    byName.put(field.getFieldName(), field);
                }
            }

            /**
             * Find the _Fields constant that matches fieldId, or null if its not found.
             */
            public static _Fields findByThriftId(int fieldId) {
                switch(fieldId) {
                    case 1: // DOC_TEXT
                        return DOC_TEXT;
                    default:
                        return null;
                }
            }

            /**
             * Find the _Fields constant that matches fieldId, throwing an exception
             * if it is not found.
             */
            public static _Fields findByThriftIdOrThrow(int fieldId) {
                _Fields fields = findByThriftId(fieldId);
                if (fields == null) throw new IllegalArgumentException("Field " + fieldId + " doesn't exist!");
                return fields;
            }

            /**
             * Find the _Fields constant that matches name, or null if its not found.
             */
            public static _Fields findByName(String name) {
                return byName.get(name);
            }

            private final short _thriftId;
            private final String _fieldName;

            _Fields(short thriftId, String fieldName) {
                _thriftId = thriftId;
                _fieldName = fieldName;
            }

            public short getThriftFieldId() {
                return _thriftId;
            }

            public String getFieldName() {
                return _fieldName;
            }
        }

        // isset id assignments
        public static final Map<_Fields, org.apache.thrift.meta_data.FieldMetaData> metaDataMap;
        static {
            Map<_Fields, org.apache.thrift.meta_data.FieldMetaData> tmpMap = new EnumMap<_Fields, org.apache.thrift.meta_data.FieldMetaData>(_Fields.class);
            tmpMap.put(_Fields.DOC_TEXT, new org.apache.thrift.meta_data.FieldMetaData("DocText", org.apache.thrift.TFieldRequirementType.DEFAULT,
                    new org.apache.thrift.meta_data.FieldValueMetaData(org.apache.thrift.protocol.TType.STRING)));
            metaDataMap = Collections.unmodifiableMap(tmpMap);
            org.apache.thrift.meta_data.FieldMetaData.addStructMetaDataMap(infer_sentiment_args.class, metaDataMap);
        }

        public infer_sentiment_args() {
        }

        public infer_sentiment_args(
                String DocText)
        {
            this();
            this.DocText = DocText;
        }

        /**
         * Performs a deep copy on <i>other</i>.
         */
        public infer_sentiment_args(infer_sentiment_args other) {
            if (other.isSetDocText()) {
                this.DocText = other.DocText;
            }
        }

        public infer_sentiment_args deepCopy() {
            return new infer_sentiment_args(this);
        }

        @Override
        public void clear() {
            this.DocText = null;
        }

        public String getDocText() {
            return this.DocText;
        }

        public infer_sentiment_args setDocText(String DocText) {
            this.DocText = DocText;
            return this;
        }

        public void unsetDocText() {
            this.DocText = null;
        }

        /** Returns true if field DocText is set (has been assigned a value) and false otherwise */
        public boolean isSetDocText() {
            return this.DocText != null;
        }

        public void setDocTextIsSet(boolean value) {
            if (!value) {
                this.DocText = null;
            }
        }

        public void setFieldValue(_Fields field, Object value) {
            switch (field) {
                case DOC_TEXT:
                    if (value == null) {
                        unsetDocText();
                    } else {
                        setDocText((String)value);
                    }
                    break;

            }
        }

        public Object getFieldValue(_Fields field) {
            switch (field) {
                case DOC_TEXT:
                    return getDocText();

            }
            throw new IllegalStateException();
        }

        /** Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise */
        public boolean isSet(_Fields field) {
            if (field == null) {
                throw new IllegalArgumentException();
            }

            switch (field) {
                case DOC_TEXT:
                    return isSetDocText();
            }
            throw new IllegalStateException();
        }

        @Override
        public boolean equals(Object that) {
            if (that == null)
                return false;
            if (that instanceof infer_sentiment_args)
                return this.equals((infer_sentiment_args)that);
            return false;
        }

        public boolean equals(infer_sentiment_args that) {
            if (that == null)
                return false;

            boolean this_present_DocText = true && this.isSetDocText();
            boolean that_present_DocText = true && that.isSetDocText();
            if (this_present_DocText || that_present_DocText) {
                if (!(this_present_DocText && that_present_DocText))
                    return false;
                if (!this.DocText.equals(that.DocText))
                    return false;
            }

            return true;
        }

        @Override
        public int hashCode() {
            return 0;
        }

        @Override
        public int compareTo(infer_sentiment_args other) {
            if (!getClass().equals(other.getClass())) {
                return getClass().getName().compareTo(other.getClass().getName());
            }

            int lastComparison = 0;

            lastComparison = Boolean.valueOf(isSetDocText()).compareTo(other.isSetDocText());
            if (lastComparison != 0) {
                return lastComparison;
            }
            if (isSetDocText()) {
                lastComparison = org.apache.thrift.TBaseHelper.compareTo(this.DocText, other.DocText);
                if (lastComparison != 0) {
                    return lastComparison;
                }
            }
            return 0;
        }

        public _Fields fieldForId(int fieldId) {
            return _Fields.findByThriftId(fieldId);
        }

        public void read(org.apache.thrift.protocol.TProtocol iprot) throws org.apache.thrift.TException {
            schemes.get(iprot.getScheme()).getScheme().read(iprot, this);
        }

        public void write(org.apache.thrift.protocol.TProtocol oprot) throws org.apache.thrift.TException {
            schemes.get(oprot.getScheme()).getScheme().write(oprot, this);
        }

        @Override
        public String toString() {
            StringBuilder sb = new StringBuilder("infer_sentiment_args(");
            boolean first = true;

            sb.append("DocText:");
            if (this.DocText == null) {
                sb.append("null");
            } else {
                sb.append(this.DocText);
            }
            first = false;
            sb.append(")");
            return sb.toString();
        }

        public void validate() throws org.apache.thrift.TException {
            // check for required fields
            // check for sub-struct validity
        }

        private void writeObject(java.io.ObjectOutputStream out) throws java.io.IOException {
            try {
                write(new org.apache.thrift.protocol.TCompactProtocol(new org.apache.thrift.transport.TIOStreamTransport(out)));
            } catch (org.apache.thrift.TException te) {
                throw new java.io.IOException(te);
            }
        }

        private void readObject(java.io.ObjectInputStream in) throws java.io.IOException, ClassNotFoundException {
            try {
                read(new org.apache.thrift.protocol.TCompactProtocol(new org.apache.thrift.transport.TIOStreamTransport(in)));
            } catch (org.apache.thrift.TException te) {
                throw new java.io.IOException(te);
            }
        }

        private static class infer_sentiment_argsStandardSchemeFactory implements SchemeFactory {
            public infer_sentiment_argsStandardScheme getScheme() {
                return new infer_sentiment_argsStandardScheme();
            }
        }

        private static class infer_sentiment_argsStandardScheme extends StandardScheme<infer_sentiment_args> {

            public void read(org.apache.thrift.protocol.TProtocol iprot, infer_sentiment_args struct) throws org.apache.thrift.TException {
                org.apache.thrift.protocol.TField schemeField;
                iprot.readStructBegin();
                while (true)
                {
                    schemeField = iprot.readFieldBegin();
                    if (schemeField.type == org.apache.thrift.protocol.TType.STOP) {
                        break;
                    }
                    switch (schemeField.id) {
                        case 1: // DOC_TEXT
                            if (schemeField.type == org.apache.thrift.protocol.TType.STRING) {
                                struct.DocText = iprot.readString();
                                struct.setDocTextIsSet(true);
                            } else {
                                org.apache.thrift.protocol.TProtocolUtil.skip(iprot, schemeField.type);
                            }
                            break;
                        default:
                            org.apache.thrift.protocol.TProtocolUtil.skip(iprot, schemeField.type);
                    }
                    iprot.readFieldEnd();
                }
                iprot.readStructEnd();

                // check for required fields of primitive type, which can't be checked in the validate method
                struct.validate();
            }

            public void write(org.apache.thrift.protocol.TProtocol oprot, infer_sentiment_args struct) throws org.apache.thrift.TException {
                struct.validate();

                oprot.writeStructBegin(STRUCT_DESC);
                if (struct.DocText != null) {
                    oprot.writeFieldBegin(DOC_TEXT_FIELD_DESC);
                    oprot.writeString(struct.DocText);
                    oprot.writeFieldEnd();
                }
                oprot.writeFieldStop();
                oprot.writeStructEnd();
            }

        }

        private static class infer_sentiment_argsTupleSchemeFactory implements SchemeFactory {
            public infer_sentiment_argsTupleScheme getScheme() {
                return new infer_sentiment_argsTupleScheme();
            }
        }

        private static class infer_sentiment_argsTupleScheme extends TupleScheme<infer_sentiment_args> {

            @Override
            public void write(org.apache.thrift.protocol.TProtocol prot, infer_sentiment_args struct) throws org.apache.thrift.TException {
                TTupleProtocol oprot = (TTupleProtocol) prot;
                BitSet optionals = new BitSet();
                if (struct.isSetDocText()) {
                    optionals.set(0);
                }
                oprot.writeBitSet(optionals, 1);
                if (struct.isSetDocText()) {
                    oprot.writeString(struct.DocText);
                }
            }

            @Override
            public void read(org.apache.thrift.protocol.TProtocol prot, infer_sentiment_args struct) throws org.apache.thrift.TException {
                TTupleProtocol iprot = (TTupleProtocol) prot;
                BitSet incoming = iprot.readBitSet(1);
                if (incoming.get(0)) {
                    struct.DocText = iprot.readString();
                    struct.setDocTextIsSet(true);
                }
            }
        }

    }

    public static class infer_sentiment_result implements org.apache.thrift.TBase<infer_sentiment_result, infer_sentiment_result._Fields>, java.io.Serializable, Cloneable, Comparable<infer_sentiment_result>   {
        private static final org.apache.thrift.protocol.TStruct STRUCT_DESC = new org.apache.thrift.protocol.TStruct("infer_sentiment_result");

        private static final org.apache.thrift.protocol.TField SUCCESS_FIELD_DESC = new org.apache.thrift.protocol.TField("success", org.apache.thrift.protocol.TType.I16, (short)0);

        private static final Map<Class<? extends IScheme>, SchemeFactory> schemes = new HashMap<Class<? extends IScheme>, SchemeFactory>();
        static {
            schemes.put(StandardScheme.class, new infer_sentiment_resultStandardSchemeFactory());
            schemes.put(TupleScheme.class, new infer_sentiment_resultTupleSchemeFactory());
        }

        public short success; // required

        /** The set of fields this struct contains, along with convenience methods for finding and manipulating them. */
        public enum _Fields implements org.apache.thrift.TFieldIdEnum {
            SUCCESS((short)0, "success");

            private static final Map<String, _Fields> byName = new HashMap<String, _Fields>();

            static {
                for (_Fields field : EnumSet.allOf(_Fields.class)) {
                    byName.put(field.getFieldName(), field);
                }
            }

            /**
             * Find the _Fields constant that matches fieldId, or null if its not found.
             */
            public static _Fields findByThriftId(int fieldId) {
                switch(fieldId) {
                    case 0: // SUCCESS
                        return SUCCESS;
                    default:
                        return null;
                }
            }

            /**
             * Find the _Fields constant that matches fieldId, throwing an exception
             * if it is not found.
             */
            public static _Fields findByThriftIdOrThrow(int fieldId) {
                _Fields fields = findByThriftId(fieldId);
                if (fields == null) throw new IllegalArgumentException("Field " + fieldId + " doesn't exist!");
                return fields;
            }

            /**
             * Find the _Fields constant that matches name, or null if its not found.
             */
            public static _Fields findByName(String name) {
                return byName.get(name);
            }

            private final short _thriftId;
            private final String _fieldName;

            _Fields(short thriftId, String fieldName) {
                _thriftId = thriftId;
                _fieldName = fieldName;
            }

            public short getThriftFieldId() {
                return _thriftId;
            }

            public String getFieldName() {
                return _fieldName;
            }
        }

        // isset id assignments
        private static final int __SUCCESS_ISSET_ID = 0;
        private byte __isset_bitfield = 0;
        public static final Map<_Fields, org.apache.thrift.meta_data.FieldMetaData> metaDataMap;
        static {
            Map<_Fields, org.apache.thrift.meta_data.FieldMetaData> tmpMap = new EnumMap<_Fields, org.apache.thrift.meta_data.FieldMetaData>(_Fields.class);
            tmpMap.put(_Fields.SUCCESS, new org.apache.thrift.meta_data.FieldMetaData("success", org.apache.thrift.TFieldRequirementType.DEFAULT,
                    new org.apache.thrift.meta_data.FieldValueMetaData(org.apache.thrift.protocol.TType.I16)));
            metaDataMap = Collections.unmodifiableMap(tmpMap);
            org.apache.thrift.meta_data.FieldMetaData.addStructMetaDataMap(infer_sentiment_result.class, metaDataMap);
        }

        public infer_sentiment_result() {
        }

        public infer_sentiment_result(
                short success)
        {
            this();
            this.success = success;
            setSuccessIsSet(true);
        }

        /**
         * Performs a deep copy on <i>other</i>.
         */
        public infer_sentiment_result(infer_sentiment_result other) {
            __isset_bitfield = other.__isset_bitfield;
            this.success = other.success;
        }

        public infer_sentiment_result deepCopy() {
            return new infer_sentiment_result(this);
        }

        @Override
        public void clear() {
            setSuccessIsSet(false);
            this.success = 0;
        }

        public short getSuccess() {
            return this.success;
        }

        public infer_sentiment_result setSuccess(short success) {
            this.success = success;
            setSuccessIsSet(true);
            return this;
        }

        public void unsetSuccess() {
            __isset_bitfield = EncodingUtils.clearBit(__isset_bitfield, __SUCCESS_ISSET_ID);
        }

        /** Returns true if field success is set (has been assigned a value) and false otherwise */
        public boolean isSetSuccess() {
            return EncodingUtils.testBit(__isset_bitfield, __SUCCESS_ISSET_ID);
        }

        public void setSuccessIsSet(boolean value) {
            __isset_bitfield = EncodingUtils.setBit(__isset_bitfield, __SUCCESS_ISSET_ID, value);
        }

        public void setFieldValue(_Fields field, Object value) {
            switch (field) {
                case SUCCESS:
                    if (value == null) {
                        unsetSuccess();
                    } else {
                        setSuccess((Short)value);
                    }
                    break;

            }
        }

        public Object getFieldValue(_Fields field) {
            switch (field) {
                case SUCCESS:
                    return Short.valueOf(getSuccess());

            }
            throw new IllegalStateException();
        }

        /** Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise */
        public boolean isSet(_Fields field) {
            if (field == null) {
                throw new IllegalArgumentException();
            }

            switch (field) {
                case SUCCESS:
                    return isSetSuccess();
            }
            throw new IllegalStateException();
        }

        @Override
        public boolean equals(Object that) {
            if (that == null)
                return false;
            if (that instanceof infer_sentiment_result)
                return this.equals((infer_sentiment_result)that);
            return false;
        }

        public boolean equals(infer_sentiment_result that) {
            if (that == null)
                return false;

            boolean this_present_success = true;
            boolean that_present_success = true;
            if (this_present_success || that_present_success) {
                if (!(this_present_success && that_present_success))
                    return false;
                if (this.success != that.success)
                    return false;
            }

            return true;
        }

        @Override
        public int hashCode() {
            return 0;
        }

        @Override
        public int compareTo(infer_sentiment_result other) {
            if (!getClass().equals(other.getClass())) {
                return getClass().getName().compareTo(other.getClass().getName());
            }

            int lastComparison = 0;

            lastComparison = Boolean.valueOf(isSetSuccess()).compareTo(other.isSetSuccess());
            if (lastComparison != 0) {
                return lastComparison;
            }
            if (isSetSuccess()) {
                lastComparison = org.apache.thrift.TBaseHelper.compareTo(this.success, other.success);
                if (lastComparison != 0) {
                    return lastComparison;
                }
            }
            return 0;
        }

        public _Fields fieldForId(int fieldId) {
            return _Fields.findByThriftId(fieldId);
        }

        public void read(org.apache.thrift.protocol.TProtocol iprot) throws org.apache.thrift.TException {
            schemes.get(iprot.getScheme()).getScheme().read(iprot, this);
        }

        public void write(org.apache.thrift.protocol.TProtocol oprot) throws org.apache.thrift.TException {
            schemes.get(oprot.getScheme()).getScheme().write(oprot, this);
        }

        @Override
        public String toString() {
            StringBuilder sb = new StringBuilder("infer_sentiment_result(");
            boolean first = true;

            sb.append("success:");
            sb.append(this.success);
            first = false;
            sb.append(")");
            return sb.toString();
        }

        public void validate() throws org.apache.thrift.TException {
            // check for required fields
            // check for sub-struct validity
        }

        private void writeObject(java.io.ObjectOutputStream out) throws java.io.IOException {
            try {
                write(new org.apache.thrift.protocol.TCompactProtocol(new org.apache.thrift.transport.TIOStreamTransport(out)));
            } catch (org.apache.thrift.TException te) {
                throw new java.io.IOException(te);
            }
        }

        private void readObject(java.io.ObjectInputStream in) throws java.io.IOException, ClassNotFoundException {
            try {
                // it doesn't seem like you should have to do this, but java serialization is wacky, and doesn't call the default constructor.
                __isset_bitfield = 0;
                read(new org.apache.thrift.protocol.TCompactProtocol(new org.apache.thrift.transport.TIOStreamTransport(in)));
            } catch (org.apache.thrift.TException te) {
                throw new java.io.IOException(te);
            }
        }

        private static class infer_sentiment_resultStandardSchemeFactory implements SchemeFactory {
            public infer_sentiment_resultStandardScheme getScheme() {
                return new infer_sentiment_resultStandardScheme();
            }
        }

        private static class infer_sentiment_resultStandardScheme extends StandardScheme<infer_sentiment_result> {

            public void read(org.apache.thrift.protocol.TProtocol iprot, infer_sentiment_result struct) throws org.apache.thrift.TException {
                org.apache.thrift.protocol.TField schemeField;
                iprot.readStructBegin();
                while (true)
                {
                    schemeField = iprot.readFieldBegin();
                    if (schemeField.type == org.apache.thrift.protocol.TType.STOP) {
                        break;
                    }
                    switch (schemeField.id) {
                        case 0: // SUCCESS
                            if (schemeField.type == org.apache.thrift.protocol.TType.I16) {
                                struct.success = iprot.readI16();
                                struct.setSuccessIsSet(true);
                            } else {
                                org.apache.thrift.protocol.TProtocolUtil.skip(iprot, schemeField.type);
                            }
                            break;
                        default:
                            org.apache.thrift.protocol.TProtocolUtil.skip(iprot, schemeField.type);
                    }
                    iprot.readFieldEnd();
                }
                iprot.readStructEnd();

                // check for required fields of primitive type, which can't be checked in the validate method
                struct.validate();
            }

            public void write(org.apache.thrift.protocol.TProtocol oprot, infer_sentiment_result struct) throws org.apache.thrift.TException {
                struct.validate();

                oprot.writeStructBegin(STRUCT_DESC);
                if (struct.isSetSuccess()) {
                    oprot.writeFieldBegin(SUCCESS_FIELD_DESC);
                    oprot.writeI16(struct.success);
                    oprot.writeFieldEnd();
                }
                oprot.writeFieldStop();
                oprot.writeStructEnd();
            }

        }

        private static class infer_sentiment_resultTupleSchemeFactory implements SchemeFactory {
            public infer_sentiment_resultTupleScheme getScheme() {
                return new infer_sentiment_resultTupleScheme();
            }
        }

        private static class infer_sentiment_resultTupleScheme extends TupleScheme<infer_sentiment_result> {

            @Override
            public void write(org.apache.thrift.protocol.TProtocol prot, infer_sentiment_result struct) throws org.apache.thrift.TException {
                TTupleProtocol oprot = (TTupleProtocol) prot;
                BitSet optionals = new BitSet();
                if (struct.isSetSuccess()) {
                    optionals.set(0);
                }
                oprot.writeBitSet(optionals, 1);
                if (struct.isSetSuccess()) {
                    oprot.writeI16(struct.success);
                }
            }

            @Override
            public void read(org.apache.thrift.protocol.TProtocol prot, infer_sentiment_result struct) throws org.apache.thrift.TException {
                TTupleProtocol iprot = (TTupleProtocol) prot;
                BitSet incoming = iprot.readBitSet(1);
                if (incoming.get(0)) {
                    struct.success = iprot.readI16();
                    struct.setSuccessIsSet(true);
                }
            }
        }

    }

}